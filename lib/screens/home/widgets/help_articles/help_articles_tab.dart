import 'package:cc_uffs/blocs/article_help/article_help_bloc.dart';
import 'package:cc_uffs/routes.dart';
import 'package:cc_uffs/screens/help/category_items_view.dart';
import 'package:cc_uffs/services/help_articles_resources.dart';
import 'package:cc_uffs/shared/widgets/custom_sliver_app_bar.dart';
import 'package:cc_uffs/shared/widgets/error_widget.dart';
import 'package:cc_uffs/shared/widgets/list_item_help.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class _Consts {
  static const listItemArticleHeaderText = 'Todas as Categorias';

  static const double bottomBarHeight = 40;
  static const double bottomBarDividerWidth = 1;
  static const double bottomBarItemFontSize = 16;

  static const bottomBarDividerColor = Colors.grey;
  static const bottomBarItemsText = ["E-MAIL", "CHAT"];
  static const bottomBarItemFontWeight = FontWeight.w700;

  static const searchWidgetMargin = const EdgeInsets.only(top: 20, bottom: 30);
  static const searchWidgetPadding = const EdgeInsets.symmetric(horizontal: 25);
  static const searchWidgetInnerPadding =
      const EdgeInsets.symmetric(horizontal: 20);
  static const double searchWidgetHeight = 50;
  static final searchWidgetBoxDecoration =
      BoxDecoration(border: Border.all(color: Colors.grey, width: 1));
}

class HelpArticlesTab extends StatefulWidget {
  const HelpArticlesTab({
    Key key,
  }) : super(key: key);

  @override
  _HelpArticlesTabState createState() => _HelpArticlesTabState();
}

class _HelpArticlesTabState extends State<HelpArticlesTab> {
  double _lastPosition = 0;

  bool _bar = true;

  _toggleBottomBar(_controller) async {
    if (_lastPosition - _controller.offset >= 2 && !_bar)
      setState(() => _bar = true);
    else if (_lastPosition - _controller.offset < 0 && _bar)
      setState(() => _bar = false);

    _lastPosition = _controller.offset;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildDefaultAppBar(),
      bottomSheet: _bar ? _BottomBar() : null,
      body: BlocBuilder<ArticleHelpBloc, ArticleHelpState>(
        builder: (context, state) {
          if (state is ArticleHelpSuccessState) {
            return _HelpPage(
              scrollListener: _toggleBottomBar,
              items: state.items,
            );
          } else if (state is ArticleHelpErrorState) {
            return CustomErrorWidget(
              message: state.error,
              onPressed: () => BlocProvider.of<ArticleHelpBloc>(context).add(
                ArticleHelpEventFetchData(),
              ),
            );
            // Todo: Show a better error widget
          } else if (state is ArticleHelpInitial) {
            BlocProvider.of<ArticleHelpBloc>(context)
                .add(ArticleHelpEventFetchData());
          }
          return _HelpPage.placeholder();
        },
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      child: Container(
        height: _Consts.bottomBarHeight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _BottomBarItem(
              text: _Consts.bottomBarItemsText[0],
              onTap: () => BlocProvider.of<ArticleHelpBloc>(context)
                  .add(ArticleHelpEventSendEmail()),
            ),
            _BottomDivider(),
            _BottomBarItem(text: _Consts.bottomBarItemsText[1]),
          ],
        ),
      ),
    );
  }
}

class _BottomDivider extends StatelessWidget {
  const _BottomDivider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _Consts.bottomBarDividerColor,
      width: _Consts.bottomBarDividerWidth,
      height: double.infinity,
    );
  }
}

class _BottomBarItem extends StatelessWidget {
  const _BottomBarItem({
    Key key,
    this.text,
    this.onTap,
  }) : super(key: key);

  final text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Container(
            child: Text(
              text,
              style: TextStyle(
                fontSize: _Consts.bottomBarItemFontSize,
                fontWeight: _Consts.bottomBarItemFontWeight,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HelpPage extends StatelessWidget {
  _HelpPage({
    Key key,
    this.scrollListener,
    placeholder,
    @required this.items,
  })  : this.placeholder = placeholder ?? false,
        super(key: key);

  final List<HelpArticleCategory> items;
  final Function scrollListener;
  final bool placeholder;

  factory _HelpPage.placeholder() {
    return _HelpPage(items: null, placeholder: true);
  }

  _goToSearchScreen(context) {
    Navigator.of(context)
        .pushNamed(RoutesNames.helpArticleSearch, arguments: items);
  }

  void _navigateToSessionItems(context, [index]) {
    Navigator.of(context).pushNamed(
      CategoryItemView.routeName,
      arguments: CategoryItemViewParams(
        category: items[index].title,
        itemList: items[index].entries,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _controller;
    _controller = ScrollController();
    _controller.addListener(() => scrollListener(_controller));

    return ListView(
      controller: _controller,
      children: <Widget>[
        _SearchWidget(
            onTap: () => _goToSearchScreen(context), placeholder: placeholder),
        ListItemArticleHeader(
            title: _Consts.listItemArticleHeaderText, placeholder: placeholder),
        if (!placeholder)
          ...items
              .asMap()
              .map(
                (index, item) => MapEntry(
                  index,
                  ListItemArticle(
                    subtitle: item.content,
                    title: item.title,
                    onClick: _navigateToSessionItems,
                    index: index,
                    placeholder: placeholder,
                  ),
                ),
              )
              .values
              .toList(),
        if (placeholder) ...ListItemArticle.placeholderList(8),
      ],
    );
  }
}

class _SearchWidget extends StatelessWidget {
  const _SearchWidget({Key key, this.onTap, this.placeholder})
      : super(key: key);

  final bool placeholder;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _Consts.searchWidgetMargin,
      padding: _Consts.searchWidgetPadding,
      child: !placeholder
          ? InkWell(
              enableFeedback: false,
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: onTap,
              child: Container(
                height: _Consts.searchWidgetHeight,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: _Consts.searchWidgetInnerPadding,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Pesquise Aqui'),
                          Icon(
                            Icons.search,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    )),
                decoration: _Consts.searchWidgetBoxDecoration,
              ),
            )
          : Container(
              height: _Consts.searchWidgetHeight,
              color: Colors.grey[300],
            ),
    );
  }
}
