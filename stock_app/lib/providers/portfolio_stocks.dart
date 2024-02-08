import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/models/buyed_stocks.dart';

class PortfolioStocksListNotifier
    extends StateNotifier<List<BuyedStocksModel>> {
  PortfolioStocksListNotifier() : super([]);
  void add(BuyedStocksModel stock) {
    state = [...state, stock];
  }

  void remove(BuyedStocksModel stock) {
    state = state.where((s) => s.stockName != stock.stockName).toList();
  }
}

final buyedStocksProvider =
    StateNotifierProvider<PortfolioStocksListNotifier, List<BuyedStocksModel>>(
        (ref) {
  return PortfolioStocksListNotifier();
});
