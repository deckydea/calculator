import 'package:calculator/model/calculator/calculator.dart';
import 'package:calculator/utils/math_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:math_expressions/math_expressions.dart';

final calculatorProvider = StateNotifierProvider<CalculatorNotifier, Calculation>((ref) => CalculatorNotifier());

class CalculatorNotifier extends StateNotifier<Calculation> {
  CalculatorNotifier() : super(const Calculation());

  // Delete the last character from the equation
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

  // Reset the calculator to its initial state
  void reset() {
    const equation = '0';
    const result = '0';
    state = state.copy(equation: equation, result: result);
  }

  // Reset the result portion of the calculator state
  void resetResult() {
    final equation = state.result;

    state = state.copy(
      equation: equation,
      shouldAppend: false,
    );
  }

  // Append a button's text to the equation
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

  // Perform the calculation based on the current equation
  void equals() {
    calculate();
    resetResult();
  }

  // Calculate the result of the current equation
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

  // Format the calculation result
  String formatResult(double result) {
    final formatter = NumberFormat('#,###.##', 'en_US');
    return formatter.format(result);
  }
}
