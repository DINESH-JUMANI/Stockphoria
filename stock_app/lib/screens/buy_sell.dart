import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/models/buyed_stocks.dart';
import 'package:stock_app/models/stock_model.dart';
import 'package:stock_app/providers/balance.dart';
import 'package:stock_app/providers/portfolio_stocks.dart';
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

  void _buyStock() {
    if (_quantityController.text.isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Enter Quantity'),
        ),
      );
      return;
    }
    double amountAvailable = ref.watch(balanceProvider);
    double totalPrice =
        widget.stock.price * double.parse(_quantityController.text);
    String stockName = widget.stock.longName;
    int quantityBuyed = int.parse(_quantityController.text);
    double buyingPrice = widget.stock.price;
    bool isPresent = false;

    if (totalPrice > amountAvailable) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Not Enough Balance'),
        ),
      );
      return;
    }
    ref.watch(balanceProvider.notifier).remove(totalPrice.toString());

    for (var element in ref.watch(buyedStocksProvider)) {
      if (element.stockName == widget.stock.longName) {
        buyingPrice = ((element.buyingPrice * element.quantityBuyed) +
                (buyingPrice * quantityBuyed)) /
            (quantityBuyed + element.quantityBuyed);
        quantityBuyed += element.quantityBuyed;
        totalPrice += element.totalAmount;
        BuyedStocksModel stock = BuyedStocksModel(
            stockName: stockName,
            buyingPrice: buyingPrice,
            quantityBuyed: quantityBuyed,
            totalAmount: totalPrice);
        ref.watch(buyedStocksProvider.notifier).remove(stock);
        ref.watch(buyedStocksProvider.notifier).add(stock);
        isPresent = true;
        break;
      }
    }

    if (!isPresent) {
      BuyedStocksModel stock = BuyedStocksModel(
          stockName: stockName,
          buyingPrice: buyingPrice,
          quantityBuyed: quantityBuyed,
          totalAmount: totalPrice);
      ref.watch(buyedStocksProvider.notifier).add(stock);
    }

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text('Successfully buyed ${_quantityController.text}'),
      ),
    );
  }

  void _sellStock() {
    if (_quantityController.text.isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Enter Quantity'),
        ),
      );
      return;
    }
    double totalPrice =
        widget.stock.price * double.parse(_quantityController.text);
    String stockName = widget.stock.longName;
    int quantityBuyed = int.parse(_quantityController.text);
    double buyingPrice = widget.stock.price;
    bool isPresent = false;
    double earnedMoney = quantityBuyed * widget.stock.price;

    for (var element in ref.watch(buyedStocksProvider)) {
      if (element.stockName == widget.stock.longName) {
        if (element.quantityBuyed < quantityBuyed) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text('Insufficient Quantity'),
            ),
          );
          return;
        }
        quantityBuyed = element.quantityBuyed - quantityBuyed;

        totalPrice = element.buyingPrice * quantityBuyed;
        BuyedStocksModel stock = BuyedStocksModel(
            stockName: stockName,
            buyingPrice: buyingPrice,
            quantityBuyed: quantityBuyed,
            totalAmount: totalPrice);

        ref.watch(buyedStocksProvider.notifier).remove(stock);
        ref.watch(buyedStocksProvider.notifier).add(stock);
        ref.watch(balanceProvider.notifier).add(earnedMoney.toString());
        isPresent = true;
        if (quantityBuyed == 0) {
          ref.watch(buyedStocksProvider.notifier).remove(stock);
        }
      }
    }
    if (isPresent) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text('Sold ${_quantityController.text} Stocks'),
        ),
      );
      return;
    }
    if (!isPresent) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('No stocks found'),
        ),
      );
      return;
    }
  }

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
    final double availableBalance = ref.watch(balanceProvider);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          InkWell(
            onTap: onClick,
            child: wishlist
                ? const Icon(Icons.bookmark)
                : const Icon(Icons.bookmark_border),
          ),
        ],
        title: Text(
          widget.stock.shortName,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
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
              "Available Balance: ${availableBalance.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 18,
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
