

import 'dart:convert';
import 'package:http/http.dart' as http;
const List<String> currenciesList = [
  'PKR',
  'USD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'AUD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
  'MANA',
  'BTR',
  'ADA',
  'USDC',
  'DOGE',
  'DAI',
  'TRX',

];
//https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=3A1AC011-71D4-4EB7-ADDE-C491EC7D7271


class CoinData {

final String websiteUrl='https://rest.coinapi.io/v1/exchangerate';
//final String apiKey='3A1AC011-71D4-4EB7-ADDE-C491EC7D7271';
final String apiKey='9051644A-A7D8-4121-ACCE-858933E08636';
Future<dynamic> getCoinData(String selectedCurrency) async {
  Map<String, String> cryptoPrices = {};
  for (String crypt in cryptoList) {
    String url =
        '$websiteUrl/$crypt/$selectedCurrency?apikey=$apiKey';
    http.Response response= await http.get(Uri.parse(url));
      String decodedData= response.body;
    var jasondata=jsonDecode(decodedData);
    if(jasondata['rate']==null)
     {
       cryptoPrices[crypt] ='?';
     } else {
        double price = jasondata['rate'];
        cryptoPrices[crypt] = price.toStringAsFixed(0);
      }
    }
  return cryptoPrices;
}

}