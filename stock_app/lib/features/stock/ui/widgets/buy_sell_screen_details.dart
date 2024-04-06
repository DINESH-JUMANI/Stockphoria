// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:stock_app/features/chart/ui/screens/chart_screen.dart';
import 'package:stock_app/features/chart/ui/widgets/show_chart.dart';
import 'package:stock_app/features/portfolio/model/portfolio.dart';
import 'package:stock_app/features/stock/model/stock_model.dart';

class BuySellScreenDetails extends StatefulWidget {
  final StockModel stock;
  final List<Portfolio> stocks;
  final int buyedQuantity;
  final double availableBalance;
  const BuySellScreenDetails({
    Key? key,
    required this.stock,
    required this.stocks,
    required this.availableBalance,
    required this.buyedQuantity,
  }) : super(key: key);

  @override
  State<BuySellScreenDetails> createState() => _BuySellScreenDetailsState();
}

class _BuySellScreenDetailsState extends State<BuySellScreenDetails> {
  final quantityController = TextEditingController();
  String range = "1y";
  String interval = "1d";
  void _buyStock() {}

  void _sellStock() {}

  void watchlistButton() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ChartScreen(
                    symbol: widget.stock.symbol,
                  ),
                ),
              ),
              child: Container(
                height: 300,
                width: double.infinity,
                child: ShowChart(
                  symbol: widget.stock.symbol,
                  interval: interval,
                  range: range,
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      range = "1d";
                      interval = "60m";
                    });
                  },
                  child: Text('1D'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      range = "5d";
                      interval = "60m";
                    });
                  },
                  child: Text('5D'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      range = "5mo";
                      interval = "1d";
                    });
                  },
                  child: Text('5M'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      range = "1y";
                      interval = "1d";
                    });
                  },
                  child: Text('1Y'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      range = "5y";
                      interval = "1d";
                    });
                  },
                  child: Text('5Y'),
                ),
              ],
            ),
            SizedBox(height: 30),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(label: Text('Quantity')),
            ),
            const SizedBox(height: 20),
            Text(
              "Price: ${widget.stock.price.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Available Balance: ${widget.availableBalance.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Buyed Quantity: ${widget.buyedQuantity}",
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _buyStock,
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.green)),
                child: const Text(
                  'Buy',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _sellStock,
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.red)),
                child: const Text(
                  'Sell',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
