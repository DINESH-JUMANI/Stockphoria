import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/models/stock_model.dart';
import 'package:stock_app/providers/wishlist.dart';

class BuySell extends ConsumerStatefulWidget {
  final StockModel stock;

  const BuySell({super.key, required this.stock});

  @override
  ConsumerState<BuySell> createState() => _BuySellState();
}

class _BuySellState extends ConsumerState<BuySell> {
  bool wishlist = false;
  final _quantityController = TextEditingController();
  final double _availableBalance = 0;

  void onClick() {
    setState(() {
      wishlist = ref
          .read(wishListProvider.notifier)
          .toggleMealFavoriteStatus(widget.stock);
      if (wishlist) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Added To WatchList'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Removed from WatchList'),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        actions: [
          InkWell(
            onTap: onClick,
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
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(label: Text('Quantity')),
            ),
            const SizedBox(height: 20),
            Text(
              "Total Price: ${widget.stock.price}",
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              "Available Balance: ${_availableBalance.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
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
                onPressed: () {},
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
