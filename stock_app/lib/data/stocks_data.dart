import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stock_app/models/raw_stocks.dart';

class StocksData {
  Future<RawStocks> fetchStocks() async {
    const Map<String, String> headers = {
      'X-RapidAPI-Key': '6686ddb192msh51cfde97ac51e37p15b3c3jsnff7c09036e21',
      'X-RapidAPI-Host': 'yh-finance.p.rapidapi.com'
    };

    final url = Uri.parse(
        'https://yh-finance.p.rapidapi.com/market/get-trending-tickers?region=US');
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return RawStocks.fromJson(body);
    }
    throw Exception('Error');
  }
}
