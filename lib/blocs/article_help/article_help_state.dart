part of 'article_help_bloc.dart';

abstract class ArticleHelpState extends Equatable {
  const ArticleHelpState();

  @override
  List<Object> get props => [];
}

class ArticleHelpInitial extends ArticleHelpState {}

class ArticleHelpLoadingState extends ArticleHelpState {}
class ArticleHelpOpenSearchState extends ArticleHelpState {}

class ArticleHelpSuccessState extends ArticleHelpState {
  final List<HelpArticleCategory> items;

  ArticleHelpSuccessState(this.items);

  @override
  List<Object> get props => [items];
}

class ArticleHelpErrorState extends ArticleHelpState {
  final String error;

  ArticleHelpErrorState(this.error);

  @override
  List<Object> get props => [error];
}
