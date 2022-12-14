import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/screens/cointicker_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CoinTickerScreen(),
      builder: EasyLoading.init(),
    );
  }
}

