import 'dart:convert';
import 'dart:developer';
import 'package:stock_app/features/chart/models/chart.dart';
import 'package:http/http.dart' as http;

class ChartRepo {
  Future<List<Chart>> fetchChartValues(
      String symbol, String range, String interval) async {
    const Map<String, String> headers = {
      'X-RapidAPI-Key': '68272d0210msh36ad4e17686d6cap10ab4fjsn59546b123a8c',
      'X-RapidAPI-Host': 'yh-finance.p.rapidapi.com'
    };
    List<Chart> chartValues = [];

    try {
      final url = Uri.parse(
          'https://yh-finance.p.rapidapi.com/stock/v2/get-chart?interval=$interval&symbol=$symbol&range=$range&region=US');
      final response = await http.get(url, headers: headers);

      final result = jsonDecode(response.body);
      List timestamps = result['chart']['result'][0]['timestamp'];
      List low = result['chart']['result'][0]['indicators']['quote'][0]['low'];
      List high =
          result['chart']['result'][0]['indicators']['quote'][0]['high'];
      List open =
          result['chart']['result'][0]['indicators']['quote'][0]['open'];
      List close =
          result['chart']['result'][0]['indicators']['quote'][0]['close'];

      for (int i = 0; i < timestamps.length; i++) {
        DateTime x = DateTime.fromMillisecondsSinceEpoch(timestamps[i] * 1000);
        Chart chartVal = Chart(
            x: x, open: open[i], close: close[i], high: high[i], low: low[i]);
        chartValues.add(chartVal);
      }
    } catch (e) {
      log("Chart repo---" + e.toString());
    }
    return chartValues;
  }
}
