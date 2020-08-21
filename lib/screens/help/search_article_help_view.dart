import 'package:cc_uffs/blocs/article_search/article_search_bloc.dart';
import 'package:cc_uffs/routes.dart';
import 'package:cc_uffs/screens/help/help_article_view.dart';
import 'package:cc_uffs/services/help_articles_resources.dart';
import 'package:cc_uffs/shared/widgets/list_item_help.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class _Consts {
  static const hintText = 'O que você quer saber?';
  static const hintStyle = const TextStyle(fontSize: 18);
  static const contentPadding =
      const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10);
}

class SearchArticleHelpView extends StatelessWidget {
  static const routeName = '/search-help';

  const SearchArticleHelpView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<HelpArticleCategory> items =
        ModalRoute.of(context).settings.arguments;

    return BlocProvider<ArticleSearchBloc>(
      create: (context) => ArticleSearchBloc(),
      child: _SearchAppBar(items),
    );
  }
}

class _SearchAppBar extends StatelessWidget {
  const _SearchAppBar(
    this.items, {
    Key key,
  }) : super(key: key);

  final List<HelpArticleCategory> items;

  @override
  Widget build(BuildContext context) {
    String _lastText = '';

    final TextEditingController _controller = TextEditingController();
    _controller.addListener(() {
      if (_lastText == _controller.text) return;
      _lastText = _controller.text;

      BlocProvider.of<ArticleSearchBloc>(context)
          .add(ArticleSearchFromQueryEvent(items: items, query: _lastText));
    });

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.grey),
          title: TextField(
            autofocus: true,
            autocorrect: true,
            enableSuggestions: true,
            decoration: InputDecoration(
              contentPadding: _Consts.contentPadding,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: .0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 1.0),
              ),
              hintText: _Consts.hintText,
              hintStyle: _Consts.hintStyle,
            ),
            controller: _controller,
          )),
      body: BlocBuilder<ArticleSearchBloc, ArticleSearchState>(
        builder: (context, state) {
          if (state is ArticleSearchInitial)
            return Container();
          else if (state is ArticleSearchErrorState) {
            // Todo: Show a better error page
            return Center(child: Text('Um erro ocorreu'));
          } else if (state is ArticleSearchSuccessState) {
            return _ResultBuilder(items: state.results);
          }
          // Loading state
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class _ResultBuilder extends StatelessWidget {
  const _ResultBuilder({
    Key key,
    this.items,
  }) : super(key: key);

  final List<HelpArticleEntrie> items;
  _goToHelpArticlePage(context, [index]) {
    Navigator.of(context).pushNamed(
      RoutesNames.helpArticle,
      arguments: HelpArticleViewRouteParams(
        article: items[index],
        category: 'Busca',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => ListItemArticle(
        index: index,
        subtitle: items[index].content,
        title: items[index].title,
        onClick: _goToHelpArticlePage,
        titleMaxLines: 4,
        titleFontWeight: FontWeight.w300,
      ),
    );
  }
}
