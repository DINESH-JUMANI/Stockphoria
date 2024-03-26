import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stock_app/data/chart_data.dart';
import 'package:stock_app/models/chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ShowChart extends StatefulWidget {
  final String symbol;
  const ShowChart({Key? key, required this.symbol}) : super(key: key);

  @override
  _ShowChartState createState() => _ShowChartState();
}

class _ShowChartState extends State<ShowChart> {
  ChartData chartData = ChartData();
  List<Chart> values = [];

  getValues() {}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: chartData.fetchChart(widget.symbol),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SpinKitCircle(
              size: 50,
              color: Colors.black,
            ),
          );
        } else
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot
                .data!.chart!.result![0].indicators!.quote![0].high!.length,
            itemBuilder: (context, index) {
              final high = snapshot
                  .data!.chart!.result![0].indicators!.quote![0].high![index];
              final low = snapshot
                  .data!.chart!.result![0].indicators!.quote![0].low![index];
              final open = snapshot
                  .data!.chart!.result![0].indicators!.quote![0].open![index];
              final close = snapshot
                  .data!.chart!.result![0].indicators!.quote![0].close![index];
              int timestamp =
                  snapshot.data!.chart!.result![0].timestamp![index];
              DateTime x =
                  DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

              values.add(
                Chart(x: x, open: open, close: close, high: high, low: low),
              );
              return SfCartesianChart(
                series: <CandleSeries>[
                  CandleSeries<Chart, DateTime>(
                    dataSource: values,
                    xValueMapper: (Chart val, _) => val.x,
                    lowValueMapper: (Chart val, _) => val.low,
                    highValueMapper: (Chart val, _) => val.high,
                    openValueMapper: (Chart val, _) => val.open,
                    closeValueMapper: (Chart val, _) => val.close,
                  ),
                ],
                primaryXAxis: DateTimeAxis(),
              );
            },
          );
      },
    );
  }
}
