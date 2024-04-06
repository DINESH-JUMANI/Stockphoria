import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final user = FirebaseAuth.instance.currentUser!;
final db = FirebaseFirestore.instance;

class BalanceRepo {
  void update(double balance) async {
    await db
        .collection('balance')
        .doc(user.uid)
        .update({'amount': balance});
  }

  Future<double> fetchBalance() async {
    try {
      final balanceData = await db.collection('balance').doc(user.uid).get();
      String balance = balanceData.data()!['amount'].toString();
      return double.parse(balance);
    } catch (e) {
      log("balance---" + e.toString());
      return 0;
    }
  }
}
