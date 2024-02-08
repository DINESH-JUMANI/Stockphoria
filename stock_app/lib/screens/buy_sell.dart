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

  void onClick() {
    setState(() {
      wishlist = ref
          .read(wishListProvider.notifier)
          .toggleMealFavoriteStatus(widget.stock);
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
