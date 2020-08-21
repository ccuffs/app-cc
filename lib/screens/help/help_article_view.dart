import 'package:cc_uffs/services/help_articles_resources.dart';
import 'package:cc_uffs/shared/widgets/custom_sliver_app_bar.dart';
import 'package:flutter/material.dart';

abstract class _Consts {
  static const articlePadding =
      const EdgeInsets.symmetric(horizontal: 20, vertical: 10);

  static const articleContentTextStyle = const TextStyle(fontSize: 18);
  static const articleContentPadding = const EdgeInsets.all(0);
  static const articleContentMargin = const EdgeInsets.only(left: 0);

  static const articleTitleTextStyle =
      const TextStyle(fontSize: 28, fontWeight: FontWeight.bold);
  static const articleTitlePadding = const EdgeInsets.all(0);
  static const articleTitleMargin = const EdgeInsets.only(bottom: 20);
}

class HelpArticleView extends StatelessWidget {
  static const routeName = '/help-article-view';

  const HelpArticleView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HelpArticleViewRouteParams arguments =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: buildWhiteAppBar(
        context,
        title: Text(
          arguments.category,
          style: TextStyle(color: Colors.grey),
        ),
      ),
      body: Padding(
        padding: _Consts.articlePadding,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Article's title
              Container(
                padding: _Consts.articleTitlePadding,
                margin: _Consts.articleTitleMargin,
                child: Text(
                  arguments.article.title,
                  style: _Consts.articleTitleTextStyle,
                ),
              ),

              // Article's content
              Container(
                margin: _Consts.articleContentMargin,
                padding: _Consts.articleContentPadding,
                child: Text(
                  arguments.article.content,
                  style: _Consts.articleContentTextStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HelpArticleViewRouteParams {
  final HelpArticleEntrie article;
  final String category;

  HelpArticleViewRouteParams({
    this.article,
    this.category,
  });
}
