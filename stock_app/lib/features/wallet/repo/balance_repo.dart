import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/providers/balance.dart';

final user = FirebaseAuth.instance.currentUser!;

class BalanceRepo {
  void add(WidgetRef ref) async {
    await FirebaseFirestore.instance
        .collection('balance')
        .doc(user.uid)
        .delete();
    await FirebaseFirestore.instance.collection('balance').doc(user.uid).set({
      'amount': ref.watch(balanceProvider),
      'id': user.uid,
    });
  }

  void fetch(WidgetRef ref) async {
    final balanceData = await FirebaseFirestore.instance
        .collection('balance')
        .doc(user.uid)
        .get();

    ref
        .watch(balanceProvider.notifier)
        .add(balanceData.data()!['amount'].toString());
  }
}
