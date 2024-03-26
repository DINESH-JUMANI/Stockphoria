import 'dart:convert';
import 'dart:developer';

import 'package:stock_app/features/stock/model/stock_model.dart';
import 'package:http/http.dart' as http;

class StockRepo {
  Future<List<StockModel>> fetchStocks() async {
    const Map<String, String> headers = {
      'X-RapidAPI-Key': '6686ddb192msh51cfde97ac51e37p15b3c3jsnff7c09036e21',
      'X-RapidAPI-Host': 'yh-finance.p.rapidapi.com'
    };
    List<StockModel> stocks = [];
    try {
      final url = Uri.parse(
          'https://yh-finance.p.rapidapi.com/market/get-trending-tickers?region=US');
      final response = await http.get(url, headers: headers);
      final result = jsonDecode(response.body);
      List stocksData = result['finance']['result'][0]['quotes'];
      for (int i = 0; i < stocksData.length; i++) {
        final shortName = stocksData[i]['shortName'];
        final longName = stocksData[i]['longName'];
        final price = stocksData[i]['regularMarketPrice'];
        final changeInPrice = stocksData[i]['regularMarketChangePercent'];
        final symbol = stocksData[i]['symbol'];
        StockModel val = StockModel(
          shortName: shortName,
          longName: longName,
          price: price,
          changeInPrice: changeInPrice,
          symbol: symbol,
        );
        stocks.add(val);
      }
    } catch (e) {
      log(e.toString());
    }
    return stocks;
  }
}
