import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stock_app/features/chart/bloc/chart_bloc.dart';
import 'package:stock_app/features/chart/models/chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ShowChart extends StatefulWidget {
  final String symbol;
  const ShowChart({Key? key, required this.symbol}) : super(key: key);

  @override
  _ShowChartState createState() => _ShowChartState();
}

class _ShowChartState extends State<ShowChart> {
  late TrackballBehavior _trackballBehavior;
  final ChartBloc chartBloc = ChartBloc();

  @override
  void initState() {
    _trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    chartBloc.add(ChartInitialFetchEvent(symbol: widget.symbol));
    super.initState();
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
              title: ChartTitle(
                text: widget.symbol,
                textStyle: TextStyle(color: Colors.white, fontSize: 20),
              ),
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
