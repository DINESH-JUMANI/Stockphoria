import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stock_app/features/stock/model/stock_model.dart';

final user = FirebaseAuth.instance.currentUser!;
final db = FirebaseFirestore.instance;
final COLLECTION_REF = "watchlist";

class WatchlistRepo {
  Future<List<StockModel>> fetchWatchlist() async {
    List<StockModel> watchlistedStocks = [];
    StockModel stock;
    final snapshots = await db
        .collection('user')
        .doc(user.uid)
        .collection(COLLECTION_REF)
        .get();
    for (var snapshot in snapshots.docs) {
      stock = StockModel(
        shortName: snapshot.data()['shortName'],
        longName: snapshot.data()['longName'],
        price: double.parse(snapshot.data()['price']),
        changeInPrice: double.parse(snapshot.data()['changeInPrice']),
        symbol: snapshot.data()['symbol'],
      );
      watchlistedStocks.add(stock);
    }
    return watchlistedStocks;
  }

  void addWatchlist(StockModel stock) {
    db
        .collection('user')
        .doc(user.uid)
        .collection(COLLECTION_REF)
        .doc(user.uid + "-" + stock.shortName)
        .set({
      'shortName': stock.shortName,
      'longName': stock.longName,
      'price': stock.price.toString(),
      'changeInPrice': stock.changeInPrice.toString(),
      'symbol': stock.symbol,
    });
  }

  void removeWatchlist(StockModel stock) {
    db
        .collection('user')
        .doc(user.uid)
        .collection(COLLECTION_REF)
        .doc(user.uid + "-" + stock.shortName)
        .delete();
  }
}
