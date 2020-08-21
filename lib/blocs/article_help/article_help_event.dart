part of 'article_help_bloc.dart';

abstract class ArticleHelpEvent extends Equatable {
  const ArticleHelpEvent();

  @override
  List<Object> get props => [];
}

class ArticleHelpEventFetchData extends ArticleHelpEvent {}

class ArticleHelpEventSearch extends ArticleHelpEvent {
  final String query;

  ArticleHelpEventSearch(this.query);
}

class ArticleHelpEventOpenSearch extends ArticleHelpEvent {}

class ArticleHelpEventSendEmail extends ArticleHelpEvent {}

class ArticleHelpEventOpenChat extends ArticleHelpEvent {}
