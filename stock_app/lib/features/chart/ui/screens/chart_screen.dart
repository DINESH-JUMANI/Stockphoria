import 'package:flutter/material.dart';
import 'package:stock_app/features/chart/ui/widgets/show_chart.dart';

class ChartScreen extends StatelessWidget {
  final String symbol;
  const ChartScreen({Key? key, required this.symbol}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: Text(symbol),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: 2000,
          child: ShowChart(
            symbol: symbol,
            interval: "1d",
            range: "5y",
          ),
        ),
      ),
    );
  }
}
