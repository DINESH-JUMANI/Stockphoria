import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/models/stock_model.dart';

class WishListNotifier extends StateNotifier<List<StockModel>> {
  WishListNotifier() : super([]);
  bool toggleMealFavoriteStatus(StockModel stock) {
    final isStockWishlisted = state.contains(stock);
    if (isStockWishlisted) {
      state = state.where((s) => s.longName != stock.longName).toList();
      return false;
    } else {
      state = [...state, stock];
      return true;
    }
  }
}

final wishListProvider =
    StateNotifierProvider<WishListNotifier, List<StockModel>>((ref) {
  return WishListNotifier();
});
