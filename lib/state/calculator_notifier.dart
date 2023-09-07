import 'package:calculator/model/calculator/calculator.dart';
import 'package:calculator/utils/math_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_expressions/math_expressions.dart';

final calculatorProvider = StateNotifierProvider<CalculatorNotifier, Calculation>((ref) => CalculatorNotifier());

class CalculatorNotifier extends StateNotifier<Calculation> {
  CalculatorNotifier() : super(const Calculation());

  void delete() {
    final equation = state.equation;

    if (equation.isNotEmpty) {
      final newEquation = equation.substring(0, equation.length - 1);

      if (newEquation.isEmpty) {
        reset();
      } else {
        state = state.copy(equation: newEquation);
        calculate();
      }
    }
  }

  void reset() {
    const equation = '0';
    const result = '0';
    state = state.copy(equation: equation, result: result);
  }

  void resetResult() {
    final equation = state.result;

    state = state.copy(
      equation: equation,
      shouldAppend: false,
    );
  }

  void append(String buttonText) {
    String equation = () {
      if (MathUtils.isOperator(buttonText) && MathUtils.isOperatorAtEnd(state.equation)) {
        final newEquation = state.equation.substring(0, state.equation.length - 1);
        return newEquation + buttonText;
      } else if (state.shouldAppend) {
        return state.equation == '0' ? buttonText : state.equation + buttonText;
      } else {
        return MathUtils.isOperator(buttonText) ? state.equation + buttonText : buttonText;
      }
    }();

    state = state.copy(equation: equation, shouldAppend: true);
    calculate();
  }

  void equals() {
    calculate();
    resetResult();
  }

  void calculate() {
    final expression = state.equation.replaceAll('⨯', '*').replaceAll('÷', '/');

    try {
      final exp = Parser().parse(expression);
      final model = ContextModel();

      final result = exp.evaluate(EvaluationType.REAL, model);
      final formattedResult = formatResult(result); // Format the result
      state = state.copy(result: formattedResult);
    } catch (e) {
      // Print error
      if (kDebugMode) {
        print(e);
      }
    }
  }

  String formatResult(double result) {
    final formattedResult = result.toStringAsFixed(2);
    return formattedResult.endsWith('.00') ? formattedResult.substring(0, formattedResult.length - 3) : formattedResult;
  }
}
