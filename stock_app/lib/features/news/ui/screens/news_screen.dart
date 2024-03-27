import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:stock_app/features/news/bloc/news_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  NewsBloc newsBloc = NewsBloc();
  final format = DateFormat('MMMM dd, yyyy');

  @override
  void initState() {
    newsBloc.add(NewsFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'News',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: BlocConsumer<NewsBloc, NewsState>(
        bloc: newsBloc,
        listenWhen: (previous, current) => current is NewsActionState,
        buildWhen: (previous, current) => current is! NewsActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case NewsFetchingLoadingState:
              return const Center(
                child: SpinKitCircle(
                  size: 50,
                  color: Colors.black,
                ),
              );
            case NewsFetchingSuccessfulState:
              final successState = state as NewsFetchingSuccessfulState;
              return ListView.separated(
                itemCount: successState.news.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: Colors.grey.shade400,
                  );
                },
                itemBuilder: (context, index) {
                  var image = successState.news[index].imageUrl;
                  String title = successState.news[index].headline;
                  DateTime date = successState.news[index].publishedAt;
                  final url = Uri.parse(successState.news[index].urlToNews);

                  return ListTile(
                    onTap: () {
                      launchUrl(
                        url,
                        mode: LaunchMode.inAppBrowserView,
                      );
                    },
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          softWrap: true,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          format.format(date),
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
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
            default:
              return Text('');
          }
        },
      ),
    );
  }
}
