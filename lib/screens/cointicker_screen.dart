import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/services/coinData.dart';
import 'package:flutter/cupertino.dart';
import 'package:bitcoin_ticker/widgets/priceCardWidget.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:io' show Platform;


class CoinTickerScreen extends StatefulWidget {
  const CoinTickerScreen({Key? key}) : super(key: key);

  @override
  State<CoinTickerScreen> createState() => _CoinTickerScreenState();
}

class _CoinTickerScreenState extends State<CoinTickerScreen> {
  String dropDownListValue = 'PKR';
  CoinData coinData=CoinData();

  Map<String, String> coinValues = {};
  bool isWaiting = false;

  void getData() async {
    isWaiting = true;
    try {
      await EasyLoading.show(status: 'loading Prices...');
      var data = await CoinData().getCoinData(dropDownListValue);
      await EasyLoading.dismiss();
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Column makeCards() {
    List<PriceCardWidgets> cryptoCards = [];
    for (String crypto in cryptoList) {
      cryptoCards.add(
        PriceCardWidgets(
          crypto: crypto,
          currency: dropDownListValue,
          currencyRate: isWaiting ? '?' : coinValues[crypto],
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoCards,
    );
  }


  CupertinoPicker getIOSList() {
    List<Text> textList = [];
    for (String currancy in currenciesList) {
      var newitem = Text(currancy,style: kCurrencyTextStyle,);
      textList.add(newitem);
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 20,
      children: textList,
      onSelectedItemChanged: (value){
        setState((){
          dropDownListValue= currenciesList[value] ;
          getData();
        });

      },
    );
  }

  DropdownButton getAndriodList() {
    List<DropdownMenuItem<String>> dropdownlist = [];
    for (String currancy in currenciesList) {
      var newitem = DropdownMenuItem<String>(
        child: Text(currancy,style: kCurrencyTextStyle),
        value: currancy,
      );
      dropdownlist.add(newitem);
    }
    return DropdownButton<String>(
          dropdownColor:  Colors.lightBlue,
      style: TextStyle(
        color: Colors.white,
      ),
      value: dropDownListValue,
      items: dropdownlist,
      onChanged: (value) {
        setState(() {
          dropDownListValue = value??'PKR';
          getData();
        });
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: Text(
          'Coin Tracker 🤑',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: ListView(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          
          Container(
            height: 55.0,
            alignment: Alignment.center,
            padding: EdgeInsets.all(10.0),
            color: Colors.lightBlue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Select the Currency :', style: kCurrencyTextStyle,),
                SizedBox(width: 20,),
                Platform.isIOS? getIOSList():getAndriodList(),
              ],
            ) ,
          ),
          makeCards(),

        ],
      ),
    );
  }
}

const kCurrencyTextStyle= TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);
