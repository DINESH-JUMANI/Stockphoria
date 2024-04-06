import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class GlobalWidgets {
  Widget splashScreen() {
    return const Center(
      child: SpinKitCircle(
        size: 50,
        color: Colors.black,
      ),
    );
  }

  void showSnackBar(BuildContext context, Color color, String text) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(text),
      ),
    );
  }
}
