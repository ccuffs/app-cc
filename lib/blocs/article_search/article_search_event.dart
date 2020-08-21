part of 'article_search_bloc.dart';

abstract class ArticleSearchEvent extends Equatable {
  const ArticleSearchEvent();

  @override
  List<Object> get props => [];
}

class ArticleSearchFromQueryEvent extends ArticleSearchEvent {
  ArticleSearchFromQueryEvent({this.query, this.items});

  final String query;
  final List<HelpArticleCategory> items;
  @override
  List<Object> get props => [query, items];
}
