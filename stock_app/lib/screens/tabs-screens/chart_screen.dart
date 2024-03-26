import 'package:flutter/material.dart';
import 'package:stock_app/widgets/show_chart.dart';

class ChartScreen extends StatelessWidget {
  final String symbol;
  const ChartScreen({Key? key, required this.symbol}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(symbol),
      ),
      body: ShowChart(symbol: symbol),
    );
  }
}
