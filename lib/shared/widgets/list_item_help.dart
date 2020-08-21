import 'package:flutter/material.dart';

abstract class _Consts {
  static const articleHeaderStyle =
      const TextStyle(fontSize: 20, fontWeight: FontWeight.w300);
  static const articleHeaderPadding = const EdgeInsets.symmetric(
    horizontal: 25,
  );

  static const listPadding = const EdgeInsets.symmetric(
    horizontal: 25,
  );

  static const listItemSubtitleStyle = const TextStyle(
    fontWeight: FontWeight.w300,
  );
  static const listItemTitleStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static const listItemInnerPadding = const EdgeInsets.symmetric(vertical: 10);
  static const listItemInnerMargin = const EdgeInsets.symmetric(vertical: 15);

  static final dividerColor = Colors.grey[300];
  static final rightIconColor = Colors.grey[300];

  static const double spaceBetweenTitleAndSubtitle = 7;
}

class ListItemArticle extends StatelessWidget {
  const ListItemArticle({
    Key key,
    @required this.onClick,
    @required this.title,
    @required this.subtitle,
    @required this.index,
    bool placeholder,
    int subtitleMaxLines,
    int titleMaxLines,
    this.titleFontWeight,
  })  : this.placeholder = placeholder ?? false,
        this.subtitleMaxLines = subtitleMaxLines,
        this.titleMaxLines = titleMaxLines ?? 1,
        super(key: key);

  final Function onClick;
  final bool placeholder;
  final String title;
  final String subtitle;
  final int index;
  final int subtitleMaxLines;
  final int titleMaxLines;
  final FontWeight titleFontWeight;

  factory ListItemArticle.placeholder() {
    return ListItemArticle(
      placeholder: true,
      index: null,
      onClick: null,
      subtitle: null,
      title: null,
    );
  }

  static List<ListItemArticle> placeholderList(int number) {
    final List<ListItemArticle> result = [];

    for (int i = 0; i < number; i++) result.add(ListItemArticle.placeholder());

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(context, index),
      child: Container(
        padding: _Consts.listPadding,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: _Consts.listItemInnerPadding,
                  margin: _Consts.listItemInnerMargin,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _Title(
                            title: title,
                            titleFontWeight: titleFontWeight,
                            titleMaxLines: titleMaxLines,
                            placeholder: placeholder,
                          ),
                          SizedBox(
                            height: _Consts.spaceBetweenTitleAndSubtitle,
                          ),
                          _Subtitle(
                            subtitle: subtitle,
                            subtitleMaxLines: subtitleMaxLines,
                            placeholder: placeholder,
                          ),
                        ],
                      )),
                ),
                _RightIcon(placeholder: placeholder),
              ],
            ),
            _Divider()
          ],
        ),
      ),
    );
  }
}

class _RightIcon extends StatelessWidget {
  const _RightIcon({
    Key key,
    @required this.placeholder,
  }) : super(key: key);

  final bool placeholder;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: !placeholder
          ? Icon(Icons.chevron_right, color: _Consts.rightIconColor)
          : Container(
              margin:
                  EdgeInsets.only(bottom: _Consts.listItemInnerMargin.bottom),
              color: Colors.grey[300],
              width: 25,
              height: 25,
            ),
    );
  }
}

class _Subtitle extends StatelessWidget {
  const _Subtitle({
    Key key,
    @required this.subtitle,
    @required this.subtitleMaxLines,
    @required this.placeholder,
  }) : super(key: key);

  final String subtitle;
  final int subtitleMaxLines;
  final bool placeholder;

  @override
  Widget build(BuildContext context) {
    return !placeholder
        ? Container(
            width: MediaQuery.of(context).size.width * .8,
            child: Text(
              subtitle,
              style: _Consts.listItemSubtitleStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: subtitleMaxLines,
            ),
          )
        : Container(
            color: Colors.grey[300],
            height: 10,
            width: MediaQuery.of(context).size.width * .65,
          );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key key,
    @required this.title,
    @required this.titleFontWeight,
    @required this.titleMaxLines,
    @required this.placeholder,
  }) : super(key: key);

  final String title;
  final FontWeight titleFontWeight;
  final int titleMaxLines;
  final bool placeholder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .75,
      child: !placeholder
          ? Text(
              title,
              style: titleFontWeight == null
                  ? _Consts.listItemTitleStyle
                  : TextStyle(
                      fontSize: _Consts.listItemTitleStyle.fontSize,
                      fontWeight: titleFontWeight,
                    ),
              overflow: TextOverflow.ellipsis,
              maxLines: titleMaxLines,
            )
          : Container(
              color: Colors.grey[300],
              height: 25,
              width: 10,
            ),
    );
  }
}

class ListItemArticleHeader extends StatelessWidget {
  const ListItemArticleHeader({
    Key key,
    this.placeholder,
    @required this.title,
  }) : super(key: key);

  final String title;
  final bool placeholder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _Consts.articleHeaderPadding,
      child: !placeholder
          ? Text(
              title,
              style: _Consts.articleHeaderStyle,
            )
          : Container(
              margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * .4),
              color: Colors.grey[300],
              height: 30,
            ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1,
      color: _Consts.dividerColor,
    );
  }
}
