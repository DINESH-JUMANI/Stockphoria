part of 'chart_bloc.dart';

@immutable
sealed class ChartEvent {}

class ChartInitialFetchEvent extends ChartEvent {
  final String symbol;
  final String range;
  final String interval;
  ChartInitialFetchEvent(
      {required this.symbol, required this.interval, required this.range});
}
