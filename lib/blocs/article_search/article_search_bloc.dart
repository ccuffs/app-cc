import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cc_uffs/services/help_articles_resources.dart';
import 'package:equatable/equatable.dart';

part 'article_search_event.dart';
part 'article_search_state.dart';

class ArticleSearchBloc extends Bloc<ArticleSearchEvent, ArticleSearchState> {
  ArticleSearchBloc() : super(ArticleSearchInitial());

  @override
  Stream<ArticleSearchState> mapEventToState(
    ArticleSearchEvent event,
  ) async* {
    if (event is ArticleSearchFromQueryEvent) {
      if (event.query.isEmpty)
        yield ArticleSearchInitial();
      else
        try {
          yield ArticleSearchLoadingState();
          final result = HelpArticleCategory.searchList(
              items: event.items, query: event.query);

          yield ArticleSearchSuccessState(result);
        } on Exception catch (_) {
          yield ArticleSearchErrorState();
        }
    }
  }
}
