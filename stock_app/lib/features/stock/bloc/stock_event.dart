part of 'stock_bloc.dart';

@immutable
sealed class StockEvent {}

class StockFetchEvent extends StockEvent {}
