part of 'chart_bloc.dart';

@immutable
sealed class ChartEvent {}

class ChartInitialFetchEvent extends ChartEvent {
  final String symbol;
  ChartInitialFetchEvent({required this.symbol});
}
