// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:stock_app/features/chart/bloc/chart_bloc.dart';
import 'package:stock_app/features/chart/models/chart.dart';

class ShowChart extends StatefulWidget {
  final String symbol;
  final String interval;
  final String range;
  const ShowChart({
    Key? key,
    required this.symbol,
    required this.interval,
    required this.range,
  }) : super(key: key);

  @override
  _ShowChartState createState() => _ShowChartState();
}

class _ShowChartState extends State<ShowChart> {
  late TrackballBehavior _trackballBehavior;
  final ChartBloc chartBloc = ChartBloc();

  @override
  void initState() {
    initialize();
    super.initState();
  }

  void initialize() {
    _trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    chartBloc.add(ChartInitialFetchEvent(
      symbol: widget.symbol,
      interval: widget.interval,
      range: widget.range,
    ));
  }

  @override
  void didUpdateWidget(covariant ShowChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChartBloc, ChartState>(
      bloc: chartBloc,
      listenWhen: (previous, current) => current is ChartActionState,
      buildWhen: (previous, current) => current is! ChartActionState,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case ChartFetchingLoadingState:
            return const Center(
              child: SpinKitCircle(
                size: 50,
                color: Colors.black,
              ),
            );
          case ChartFetchingSuccessfulState:
            final successState = state as ChartFetchingSuccessfulState;
            return SfCartesianChart(
              trackballBehavior: _trackballBehavior,
              series: <CandleSeries>[
                CandleSeries<Chart, DateTime>(
                  dataSource: successState.chartValues,
                  xValueMapper: (Chart val, _) => val.x,
                  lowValueMapper: (Chart val, _) => val.low,
                  highValueMapper: (Chart val, _) => val.high,
                  openValueMapper: (Chart val, _) => val.open,
                  closeValueMapper: (Chart val, _) => val.close,
                ),
              ],
              primaryXAxis: DateTimeAxis(),
            );

          default:
            return Text('');
        }
      },
    );
  }
}
