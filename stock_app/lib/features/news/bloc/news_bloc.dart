import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stock_app/features/news/model/news.dart';
import 'package:stock_app/features/news/repos/news_repo.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()) {
    on<NewsFetchEvent>(newsFetchEvent);
  }

  FutureOr<void> newsFetchEvent(
      NewsFetchEvent event, Emitter<NewsState> emit) async {
    emit(NewsFetchingLoadingState());
    try {
      List<News> news = await NewsRepo().fetchNews();
      emit(NewsFetchingSuccessfulState(news: news));
    } catch (e) {
      log(e.toString());
      emit(NewsFetchingErrorState());
    }
  }
}
