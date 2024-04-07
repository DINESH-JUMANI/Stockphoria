import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stock_app/features/stock/model/stock_model.dart';
import 'package:stock_app/features/watchlist/repo/watchlist_repo.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc() : super(WatchlistInitial()) {
    on<WatchlistFetchEvent>(watchlistFetchEvent);
    on<WatchlistAddEvent>(watchlistAddEvent);
    on<WatchlistRemoveEvent>(watchlistRemoveEvent);
  }
  List<StockModel> watchlistedStocks = [];

  FutureOr<void> watchlistFetchEvent(
      WatchlistFetchEvent event, Emitter<WatchlistState> emit) async {
    emit(WatchlistFetchingLoadingState());
    try {
      watchlistedStocks = await WatchlistRepo().fetchWatchlist();
      emit(WatchlistFetchingSuccessfulState(
          watchlistedStocks: watchlistedStocks));
    } catch (e) {
      log('Watchlist Bloc');
      emit(WatchlistFetchingErrorState());
    }
  }

  FutureOr<void> watchlistAddEvent(
      WatchlistAddEvent event, Emitter<WatchlistState> emit) {
    WatchlistRepo().addWatchlist(event.stock);
    emit(WatchlistAddState());
  }

  FutureOr<void> watchlistRemoveEvent(
      WatchlistRemoveEvent event, Emitter<WatchlistState> emit) {
    WatchlistRepo().removeWatchlist(event.stock);
    emit(WatchlistRemoveState());
  }
}
