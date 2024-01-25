import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stock_app/models/news.dart';

class NewsData {
  Future<News> fetchNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=8f6da3c3f9c74296af47f6472397f50c";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return News.fromJson(body);
    }
    throw Exception('Error');
  }
}
