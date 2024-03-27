part of 'news_bloc.dart';

@immutable
sealed class NewsEvent {}

class NewsFetchEvent extends NewsEvent {}
