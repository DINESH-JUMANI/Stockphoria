import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/providers/portfolio_stocks.dart';

class PortfolioScreen extends ConsumerWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listOfBuyedStocks = ref.watch(buyedStocksProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Portfolio'),
      ),
      body: ListView.builder(
        itemCount: listOfBuyedStocks.length,
        itemBuilder: (context, index) {
          String stockName = listOfBuyedStocks[index].stockName;
          double buyingPrice = listOfBuyedStocks[index].buyingPrice;
          int quantity = listOfBuyedStocks[index].quantityBuyed;
          double totalAmount = listOfBuyedStocks[index].totalAmount;
          return Card(
            margin: const EdgeInsets.all(12),
            color: Colors.grey.shade300,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          stockName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Quantity: ${quantity.toString()}',
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'LTP: ${buyingPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          totalAmount.toStringAsFixed(2),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
