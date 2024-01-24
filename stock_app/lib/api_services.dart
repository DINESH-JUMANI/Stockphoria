import 'package:stock_app/models/news.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  final url =
      "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=8f6da3c3f9c74296af47f6472397f50c";

  Future<List<News>?> getNews() async {
    final uri = Uri.parse(url);
    final response = await http.post(Uri.file(''));
    return null;
  }
}
