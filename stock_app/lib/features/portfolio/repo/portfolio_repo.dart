import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stock_app/features/portfolio/model/portfolio.dart';

final user = FirebaseAuth.instance.currentUser!;
final db = FirebaseFirestore.instance;

class PortfolioRepo {
  void update(Portfolio portfolioStock) async {
    bool isPresent = false;
    List<Portfolio> portfolio = await fetchPortfolio();
    for (int i = 0; i < portfolio.length; i++) {
      if (portfolio[i].stockName == portfolioStock.stockName) {
        isPresent = true;
        db.collection('portfolio').doc(user.uid).update({
          'user-id': user.uid,
          'stock-name': portfolioStock.stockName,
          'buying-price': portfolioStock.buyingPrice,
          'quantity': portfolioStock.quantityBuyed,
          'amount': portfolioStock.totalAmount,
        });
        break;
      }
    }
    if (!isPresent) {
      db.collection('portfolio').doc(user.uid).set({
        'user-id': user.uid,
        'stock-name': portfolioStock.stockName,
        'buying-price': portfolioStock.buyingPrice,
        'quantity': portfolioStock.quantityBuyed,
        'amount': portfolioStock.totalAmount,
      });
    }
  }

  Future<List<Portfolio>> fetchPortfolio() async {
    List<Portfolio> portfolio = [];
    int length = db.collection('portfolio').toString().length;
    for (int i = 0; i < length; i++) {
      final portfolioData =
          await db.collection('portfolio').doc(user.uid).get();
      if (portfolioData.data() == null) return [];

      Portfolio data = Portfolio(
          userId: portfolioData.data()!['user-id'].toString(),
          stockName: portfolioData.data()!['stock-name'].toString(),
          buyingPrice:
              double.parse(portfolioData.data()!['buying-price'].toString()),
          quantityBuyed:
              int.parse(portfolioData.data()!['quantity'].toString()),
          totalAmount:
              double.parse(portfolioData.data()!['amount'].toString()));
      portfolio.add(data);
    }
    return portfolio;
  }
}
