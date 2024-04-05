import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:stock_app/features/chart/repos/chart_repo.dart';

import '../models/chart.dart';

part 'chart_event.dart';
part 'chart_state.dart';

class ChartBloc extends Bloc<ChartEvent, ChartState> {
  ChartBloc() : super(ChartInitial()) {
    on<ChartInitialFetchEvent>(chartInitialFetchEvent);
  }

  FutureOr<void> chartInitialFetchEvent(
      ChartInitialFetchEvent event, Emitter<ChartState> emit) async {
    emit(ChartFetchingLoadingState());
    try {
      List<Chart> chartValues = await ChartRepo()
          .fetchChartValues(event.symbol, event.interval, event.range);
      emit(ChartFetchingSuccessfulState(chartValues: chartValues));
    } catch (e) {
      log(e.toString());
      emit(ChartFetchingErrorState());
    }
  }
}
