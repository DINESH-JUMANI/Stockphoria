import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/features/auth/ui/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stock_app/features/portfolio/bloc/portfolio_bloc.dart';
import 'package:stock_app/features/wallet/bloc/wallet_bloc.dart';
import 'package:stock_app/tabs.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Widget currentScreen = StreamBuilder(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (ctx, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      }
      final user = FirebaseAuth.instance.currentUser;

      if (user != null && snapshot.hasData && user.emailVerified) {
        return const Tabs();
      }

      return const LoginScreen();
    },
  );
  runApp(
    ProviderScope(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => PortfolioBloc()),
          BlocProvider(create: (context) => WalletBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: currentScreen,
        ),
      ),
    ),
  );
}
