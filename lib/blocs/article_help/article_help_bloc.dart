import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cc_uffs/services/help_articles_resources.dart';
import 'package:cc_uffs/shared/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:url_launcher/url_launcher.dart';

part 'article_help_event.dart';
part 'article_help_state.dart';

class ArticleHelpBloc extends Bloc<ArticleHelpEvent, ArticleHelpState> {
  ArticleHelpBloc() : super(ArticleHelpInitial());
  List<HelpArticleCategory> _items;

  @override
  Stream<ArticleHelpState> mapEventToState(
    ArticleHelpEvent event,
  ) async* {
    if (event is ArticleHelpEventFetchData) {
      yield ArticleHelpLoadingState();

      final items = await HelpArticlesResource.fetchHelp();
      _items = items;
      yield ArticleHelpSuccessState([..._items]);
    }
    if (event is ArticleHelpEventOpenSearch) {
      yield ArticleHelpOpenSearchState();
    }
    if (event is ArticleHelpEventSendEmail) {
      final url = "mailto:$HELP_MAIL_ADDRESS_CH?subject=$HELP_MAIL_SUBJECT";
      if (await canLaunch(url)) {
        await launch(
          url,
          forceSafariVC: false,
        );
      } else {
        yield ArticleHelpErrorState('Um erro ocorreu');
        throw 'Could not launch $url';
      }
    }
    if (event is ArticleHelpEventOpenChat) {}
  }
}
