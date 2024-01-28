import 'package:flutter/material.dart';
import 'package:stock_app/models/stock_model.dart';

class BuySell extends StatefulWidget {
  final StockModel stock;

  const BuySell({super.key, required this.stock});

  @override
  State<BuySell> createState() => _BuySellState();
}

class _BuySellState extends State<BuySell> {
  bool wishlist = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        actions: [
          InkWell(
            onTap: () {
              setState(() {
                wishlist = !wishlist;
              });
            },
            child: wishlist
                ? const Icon(Icons.bookmark)
                : const Icon(Icons.bookmark_border),
          ),
        ],
        title: Center(
          child: Text(
            widget.stock.shortName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(),
    );
  }
}
