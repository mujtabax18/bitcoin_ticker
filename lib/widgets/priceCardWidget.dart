import 'package:flutter/material.dart';

class PriceCardWidgets extends StatelessWidget {
      PriceCardWidgets(
      {required this.crypto,
      required this.currencyRate,
      required this.currency});
      String? currencyRate;
     String crypto;
     String currency;
  @override
  Widget build(BuildContext context) {
    return  Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $crypto = $currencyRate $currency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
