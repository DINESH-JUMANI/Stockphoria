import 'package:flutter/material.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/logo.png',
            width: 200,
            height: 180,
            color: Colors.black87,
          ),
          const SizedBox(height: 20),
          const Text(
            'Add Stocks in Watchlist!',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Watchlist',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: content,
    );
  }
}
