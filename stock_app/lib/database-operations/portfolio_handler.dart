import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/models/buyed_stocks.dart';
import 'package:stock_app/providers/portfolio_stocks.dart';

final user = FirebaseAuth.instance.currentUser!;

class PortfolioHandler {
  void add(WidgetRef ref) async {
    int increment = 0;
    var collection = FirebaseFirestore.instance.collection('portfolio');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
    final listOfStocks = ref.watch(buyedStocksProvider);

    for (var stock in listOfStocks) {
      await FirebaseFirestore.instance
          .collection('portfolio')
          .doc('${user.uid}$increment')
          .set({
        'user-id': user.uid,
        'stock-name': stock.stockName,
        'buying-price': stock.buyingPrice,
        'quantity': stock.quantityBuyed,
        'amount': stock.totalAmount,
      });
      increment++;
    }
  }

  void fetch(WidgetRef ref) async {
    int length =
        FirebaseFirestore.instance.collection('portfolio').toString().length;
    for (int i = 0; i < length; i++) {
      final portfolioData = await FirebaseFirestore.instance
          .collection('portfolio')
          .doc('${user.uid}$i')
          .get();

      BuyedStocksModel stock = BuyedStocksModel(
          stockName: portfolioData.data()!['stock-name'].toString(),
          buyingPrice:
              double.parse(portfolioData.data()!['buying-price'].toString()),
          quantityBuyed:
              int.parse(portfolioData.data()!['quantity'].toString()),
          totalAmount:
              double.parse(portfolioData.data()!['amount'].toString()));
      ref.watch(buyedStocksProvider.notifier).add(stock);
    }
  }
}
