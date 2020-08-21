part of 'article_search_bloc.dart';

abstract class ArticleSearchState extends Equatable {
  const ArticleSearchState();

  @override
  List<Object> get props => [];
}

class ArticleSearchInitial extends ArticleSearchState {}

class ArticleSearchErrorState extends ArticleSearchState {}

class ArticleSearchLoadingState extends ArticleSearchState {}

class ArticleSearchSuccessState extends ArticleSearchState {
  ArticleSearchSuccessState(this.results);

  final List<HelpArticleEntrie> results;

  @override
  List<Object> get props => [results];
}
