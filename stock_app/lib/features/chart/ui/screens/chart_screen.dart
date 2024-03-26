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
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      body: ShowChart(symbol: symbol),
    );
  }
}
