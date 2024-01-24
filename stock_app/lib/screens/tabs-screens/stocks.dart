import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/data/dummy_stocks.dart';

class StocksScreen extends ConsumerWidget {
  const StocksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stocks = dummyStocks;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Stocks',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey.shade400,
          );
        },
        itemCount: stocks.length,
        itemBuilder: (ctx, index) {
          final stock = stocks[index];
          String price = stock.price.toStringAsFixed(2);
          String changeInPrice = stock.changeInPrice.toStringAsFixed(2);
          return ListTile(
            contentPadding: const EdgeInsets.all(10),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Text(
                    stock.company.characters.first,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stock.symbol,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      stock.company,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (stock.changeInPrice >= 0)
                  Text(
                    '+$changeInPrice%',
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                    ),
                  )
                else
                  Text(
                    '$changeInPrice%',
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
