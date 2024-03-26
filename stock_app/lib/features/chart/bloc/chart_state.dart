part of 'chart_bloc.dart';

@immutable
sealed class ChartState {}

abstract class ChartActionState extends ChartState {}

final class ChartInitial extends ChartState {}

class ChartFetchingLoadingState extends ChartState {}

class ChartFetchingErrorState extends ChartState {}

class ChartFetchingSuccessfulState extends ChartState {
  final List<Chart> chartValues;

  ChartFetchingSuccessfulState({required this.chartValues});
}
