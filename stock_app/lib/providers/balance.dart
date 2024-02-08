import 'package:flutter_riverpod/flutter_riverpod.dart';

class BalanceNotifier extends StateNotifier<double> {
  BalanceNotifier() : super(0);
  void add(String num) {
    state = state + double.parse(num);
  }

  void remove(String num) {
    state = state - double.parse(num);
    if (state < 0) state = 0;
  }
}

final balanceProvider = StateNotifierProvider<BalanceNotifier, double>((ref) {
  return BalanceNotifier();
});
