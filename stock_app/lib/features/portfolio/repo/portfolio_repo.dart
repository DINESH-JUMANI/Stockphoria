import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stock_app/features/portfolio/model/portfolio.dart';

final user = FirebaseAuth.instance.currentUser!;
final db = FirebaseFirestore.instance;
final COLLECTION_REF = "portfolio";

class PortfolioRepo {
  void update(Portfolio portfolioStock) async {
    bool isPresent = false;

    List<Portfolio> portfolio = await fetchPortfolio();
    for (int i = 0; i < portfolio.length; i++) {
      if (portfolio[i].stockName == portfolioStock.stockName) {
        isPresent = true;

        db
            .collection(COLLECTION_REF)
            .doc(user.uid + "-" + portfolioStock.stockName)
            .update({
          'user-id': user.uid,
          'stock-name': portfolioStock.stockName,
          'buying-price': portfolioStock.buyingPrice.toString(),
          'quantity': portfolioStock.quantityBuyed.toString(),
          'amount': portfolioStock.totalAmount.toString(),
        });
        break;
      }
    }
    if (!isPresent) {
      add(portfolioStock);
    }
  }

  void add(Portfolio portfolioStock) {
    db
        .collection(COLLECTION_REF)
        .doc(user.uid + "-" + portfolioStock.stockName)
        .set({
      'user-id': user.uid,
      'stock-name': portfolioStock.stockName,
      'buying-price': portfolioStock.buyingPrice.toString(),
      'quantity': portfolioStock.quantityBuyed.toString(),
      'amount': portfolioStock.totalAmount.toString(),
    });
  }

  void remove(Portfolio portfolioStock) {
    db
        .collection(COLLECTION_REF)
        .doc(user.uid + "-" + portfolioStock.stockName)
        .delete();
  }

  Future<List<Portfolio>> fetchPortfolio() async {
    List<Portfolio> portfolio = [];
    final snapshots = await db.collection(COLLECTION_REF).get();
    for (var snapshot in snapshots.docs) {
      Portfolio data = Portfolio(
          userId: snapshot.data()['user-id'],
          stockName: snapshot.data()['stock-name'],
          buyingPrice: double.parse(snapshot.data()['buying-price']),
          quantityBuyed: int.parse(snapshot.data()['quantity']),
          totalAmount: double.parse(snapshot.data()['amount']));
      portfolio.add(data);
    }
    return portfolio;
  }
}
