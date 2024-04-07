// ignore_for_file: must_be_immutable

part of 'watchlist_bloc.dart';

@immutable
sealed class WatchlistEvent {}

class WatchlistFetchEvent extends WatchlistEvent {}

class WatchlistAddEvent extends WatchlistEvent {
  StockModel stock;
  WatchlistAddEvent(this.stock);
}

class WatchlistRemoveEvent extends WatchlistEvent {
  StockModel stock;
  WatchlistRemoveEvent(this.stock);
}
