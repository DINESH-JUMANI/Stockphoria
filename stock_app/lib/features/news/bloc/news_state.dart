part of 'news_bloc.dart';

@immutable
sealed class NewsState {}

final class NewsInitial extends NewsState {}

abstract class NewsActionState extends NewsState {}

class NewsFetchingLoadingState extends NewsState {}

class NewsFetchingErrorState extends NewsState {}

class NewsFetchingSuccessfulState extends NewsState {
  final List<News> news;
  NewsFetchingSuccessfulState({required this.news});
}
