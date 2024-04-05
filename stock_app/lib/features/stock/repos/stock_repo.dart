import 'dart:convert';
import 'dart:developer';

import 'package:stock_app/features/stock/model/stock_model.dart';
import 'package:http/http.dart' as http;

class StockRepo {
  Future<List<StockModel>> fetchStocks() async {
    const Map<String, String> headers = {
      'X-RapidAPI-Key': '68272d0210msh36ad4e17686d6cap10ab4fjsn59546b123a8c',
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
        if (shortName == null ||
            longName == null ||
            price == null ||
            changeInPrice == null ||
            symbol == null) continue;
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
      log("Stock repo---" + e.toString());
    }
    return stocks;
  }
}
