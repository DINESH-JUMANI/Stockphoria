import 'dart:convert';
import 'dart:developer';

import 'package:stock_app/features/news/model/news.dart';
import 'package:http/http.dart' as http;

class NewsRepo {
  Future<List<News>> fetchNews() async {
    List<News> news = [];
    try {
      String url =
          "https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=8f6da3c3f9c74296af47f6472397f50c";

      final response = await http.get(Uri.parse(url));
      final result = jsonDecode(response.body);
      List totalNewsData = result['articles'];
      for (int i = 0; i < totalNewsData.length; i++) {
        final title = totalNewsData[i]['title'];
        var imageUrl = totalNewsData[i]['urlToImage'];
        imageUrl ??=
            'https://cdn.icon-icons.com/icons2/2783/PNG/512/photo_error_icon_177258.png';
        final newsUrl = totalNewsData[i]['url'];
        final publishedAt = totalNewsData[i]['publishedAt'];
        DateTime date = DateTime.parse(publishedAt);

        final newsData = News(
            imageUrl: imageUrl,
            headline: title,
            urlToNews: newsUrl,
            publishedAt: date);

        news.add(newsData);
      }
    } catch (e) {
      log(e.toString());
    }
    return news;
  }
}
