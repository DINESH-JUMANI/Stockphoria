import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:stock_app/data/news_data.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  NewsData news = NewsData();
  final format = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'News',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
        future: news.fetchNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: SpinKitCircle(
              size: 50,
              color: Colors.black,
            ));
          } else {
            return ListView.separated(
              itemCount: snapshot.data!.articles!.length,
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: Colors.grey.shade400,
                );
              },
              itemBuilder: (context, index) {
                var image = snapshot.data!.articles![index].urlToImage;
                String title = snapshot.data!.articles![index].title.toString();
                DateTime date = DateTime.parse(
                    snapshot.data!.articles![index].publishedAt.toString());
                image ??=
                    'https://cdn.icon-icons.com/icons2/2783/PNG/512/photo_error_icon_177258.png';
                String url = snapshot.data!.articles![index].url.toString();

                return ListTile(
                  onTap: () {},
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        softWrap: true,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        format.format(date),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  trailing: SizedBox(
                    height: double.maxFinite,
                    width: 150,
                    child: Image.network(
                      image.toString(),
                      fit: BoxFit.fill,
                      height: double.infinity,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
