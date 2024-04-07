part of 'watchlist_bloc.dart';

@immutable
sealed class WatchlistState {}

final class WatchlistInitial extends WatchlistState {}

abstract class WatchlistActionState extends WatchlistState {}

class WatchlistFetchingLoadingState extends WatchlistState {}

class WatchlistFetchingErrorState extends WatchlistState {}

class WatchlistFetchingSuccessfulState extends WatchlistState {
  final List<StockModel> watchlistedStocks;

  WatchlistFetchingSuccessfulState({required this.watchlistedStocks});
}

class WatchlistAddState extends WatchlistActionState {}

class WatchlistRemoveState extends WatchlistActionState {}
