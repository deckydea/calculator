import 'package:calculator/model/calculator/calculator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Not yet implemented
class HistoryCalculator extends StateNotifier<List<Calculation>> {
  HistoryCalculator() : super([]);

  void onAdd(Calculation calculation) {
    final list = state.toList();
    list.add(calculation);
    state = list;
  }

  void onClear() => state.clear();
}
