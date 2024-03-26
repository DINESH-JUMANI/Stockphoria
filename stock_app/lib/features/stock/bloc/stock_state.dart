part of 'stock_bloc.dart';

@immutable
sealed class StockState {}

final class StockInitial extends StockState {}

abstract class StockActionState extends StockState {}

class StockFetchingLoadingState extends StockState {}

class StockFetchingErrorState extends StockState {}

class StockFetchingSuccessfulState extends StockState {
  final List<StockModel> stocks;
  StockFetchingSuccessfulState({required this.stocks});
}
