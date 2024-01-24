class News {
  final String title;
  final String publishedAt;
  final String url;
  final String urlToImage;

  News(
      {required this.title,
      required this.publishedAt,
      required this.url,
      required this.urlToImage});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'] as String,
      publishedAt: json['publishedAt'] as String,
      url: json['url'] as String,
      urlToImage: json['urlToImage'] as String,
    );
  }
}
