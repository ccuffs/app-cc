import 'package:cc_uffs/screens/help/help_article_view.dart';
import 'package:cc_uffs/services/help_articles_resources.dart';
import 'package:cc_uffs/shared/widgets/custom_sliver_app_bar.dart';
import 'package:cc_uffs/shared/widgets/list_item_help.dart';
import 'package:flutter/material.dart';

class CategoryItemView extends StatelessWidget {
  static const routeName = '/category-item';
  const CategoryItemView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CategoryItemViewParams args =
        ModalRoute.of(context).settings.arguments;
    final itemList = args.itemList;

    _goToHelpArticlePage(context, [index]) {
      Navigator.of(context).pushNamed(
        HelpArticleView.routeName,
        arguments: HelpArticleViewRouteParams(
          article: itemList[index],
          category: args.category,
        ),
      );
    }

    return Scaffold(
      appBar: buildWhiteAppBar(
        context,
        title: Text(
          "Ajuda",
          style: TextStyle(color: Colors.grey),
        ),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: itemList.length,
          itemBuilder: (context, index) => ListItemArticle(
            index: index,
            subtitle: itemList[index].content,
            title: itemList[index].title,
            onClick: _goToHelpArticlePage,
            titleMaxLines: 4,
            titleFontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}

class CategoryItemViewParams {
  final List<HelpArticleEntrie> itemList;
  final String category;

  CategoryItemViewParams({this.itemList, this.category});
}
