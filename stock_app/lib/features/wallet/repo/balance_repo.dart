import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final user = FirebaseAuth.instance.currentUser!;
final db = FirebaseFirestore.instance;

class BalanceRepo {
  void update(double balance) async {
    try {
      await db
          .collection('user')
          .doc(user.uid)
          .collection('balance')
          .doc(user.uid)
          .update({'amount': balance});
    } catch (e) {
      log(e.toString());
      add(balance);
    }
  }

  void add(double balance) async {
    await db
        .collection('user')
        .doc(user.uid)
        .collection('balance')
        .doc(user.uid)
        .set({'amount': balance});
  }

  Future<double> fetchBalance() async {
    try {
      final balanceData = await db
          .collection('user')
          .doc(user.uid)
          .collection('balance')
          .doc(user.uid)
          .get();
      String balance = balanceData.data()!['amount'].toString();
      return double.parse(balance);
    } catch (e) {
      log("balance---" + e.toString());
      return 0;
    }
  }
}
