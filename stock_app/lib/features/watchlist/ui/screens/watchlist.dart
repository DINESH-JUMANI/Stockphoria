import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/providers/wishlist.dart';
import 'package:stock_app/features/stock/ui/widgets/show_stocks.dart';

class WatchlistScreen extends ConsumerStatefulWidget {
  const WatchlistScreen({super.key});

  @override
  ConsumerState<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends ConsumerState<WatchlistScreen> {
  @override
  Widget build(BuildContext context) {
    final listOfWishListStocks = ref.watch(wishListProvider);
    Widget content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/logo.png',
            width: 130,
            height: 150,
            color: Colors.black87,
          ),
          const SizedBox(height: 20),
          const Text(
            'Add Stocks in Watchlist!',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
    if (listOfWishListStocks.isNotEmpty) {
      setState(() {
        content = const ShowStocks();
      });
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Watchlist',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: content,
    );
  }
}
