import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stock_app/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stock_app/screens/stocks.dart';
import 'package:stock_app/screens/tabs.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StocksScreen(),
      // home: StreamBuilder(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (ctx, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const CircularProgressIndicator();
      //     }

      //     if (snapshot.hasData) {
      //       return const Tabs();
      //     }

      //     return const LoginScreen();
      //   },
      // ),
    ),
  );
}
