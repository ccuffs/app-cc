import 'package:cc_uffs/routes.dart';
import 'package:flutter/material.dart';
import 'package:site_cc_parser/site_cc_parser.dart';
import 'package:transparent_image/transparent_image.dart';

class DisplayPost extends StatelessWidget {
  const DisplayPost({Key key, placeholder, this.items})
      : this.placeholder = placeholder ?? false,
        super(key: key);

  final bool placeholder;
  final List<ParserSiteResponse> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: placeholder == true ? 7 : items.length,
        itemBuilder: (context, index) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _PostItem(
                item: items != null ? items[index] : null,
                placeholder: placeholder),
            if (placeholder || index < items.length - 1)
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[200],
              ),
          ],
        ),
      ),
    );
  }
}

class _PostItem extends StatelessWidget {
  const _PostItem({
    Key key,
    this.item,
    placeholder,
  })  : this.placeholder = placeholder ?? false,
        super(key: key);

  final ParserSiteResponse item;
  final bool placeholder;

  @override
  Widget build(BuildContext context) {
    int maxLines = 1;

    if (!placeholder && item.title.length < 25)
      maxLines = 3;
    else if (!placeholder && item.title.length < 45) maxLines = 2;

    return InkWell(
      onTap: () =>
          Navigator.of(context).pushNamed(RoutesNames.reader, arguments: item),
      child: Container(
        width: double.infinity,
        height: 155,
        color: Colors.white38,
        padding: EdgeInsets.only(
          right: _Consts.paddingHorizontal,
          left: _Consts.paddingHorizontal,
          bottom: _Consts.paddingVertical,
          top: _Consts.paddingVertical + 10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _Title(
                    title: item != null ? item.title : null,
                    placeholder: placeholder,
                  ),
                  _ShortDescription(
                    shortDescription:
                        item != null ? item.shortDescription : null,
                    maxLines: maxLines,
                    placeholder: placeholder,
                  ),
                  Expanded(child: Container()),
                  _Footer(
                    author: placeholder ? null : item.author,
                    date: placeholder ? null : item.date,
                    formatedDate: placeholder ? null : item.formatedDate,
                    placeholder: placeholder,
                  ),
                ],
              ),
            ),
            _FeaturedImage(
              placeholder: placeholder,
              image: placeholder
                  ? null
                  : FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: item.image,
                      fit: BoxFit.cover,
                    ),
              authorImage: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: placeholder
                    ? null
                    : FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: item.authorImage,
                        fit: BoxFit.cover,
                      ),
              ),
              circularAuthorImage: true,
            )
          ],
        ),
      ),
    );
  }
}

class PlaceholderContainer extends StatelessWidget {
  const PlaceholderContainer({
    Key key,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[200],
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({
    Key key,
    @required this.author,
    @required this.date,
    @required this.formatedDate,
    placeholder,
  })  : this.placeholder = placeholder ?? false,
        super(key: key);

  final DateTime date;
  final String author;
  final String formatedDate;
  final bool placeholder;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Row(
        children: <Widget>[
          placeholder
              ? PlaceholderContainer(
                  width: MediaQuery.of(context).size.width * .20,
                  height: 10,
                )
              : Text(
                  author,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
          SizedBox(width: 8),
          placeholder
              ? PlaceholderContainer(
                  width: MediaQuery.of(context).size.width * .20,
                  height: 10,
                )
              : Text(
                  formatedDate,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 11.5,
                  ),
                ),
        ],
      ),
    );
  }
}

class _ShortDescription extends StatelessWidget {
  const _ShortDescription({
    Key key,
    @required this.shortDescription,
    @required this.maxLines,
    placeholder,
  })  : this.placeholder = placeholder ?? false,
        super(key: key);

  final String shortDescription;
  final int maxLines;
  final bool placeholder;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: placeholder ? Alignment.topLeft : Alignment.center,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 15,
          top: 15,
          right: _Consts.titleRightPadding,
        ),
        child: placeholder
            ? Column(
                children: <Widget>[
                  PlaceholderContainer(
                    width: MediaQuery.of(context).size.width * .6,
                    height: 16,
                  ),
                  SizedBox(height: 10),
                  PlaceholderContainer(
                    width: MediaQuery.of(context).size.width * .6,
                    height: 16,
                  ),
                ],
              )
            : Text(
                shortDescription,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  height: 1.2,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: maxLines,
              ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key key,
    @required this.title,
    placeholder,
  })  : this.placeholder = placeholder ?? false,
        super(key: key);

  final String title;
  final bool placeholder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        right: _Consts.titleRightPadding,
      ),
      child: placeholder
          ? PlaceholderContainer(
              width: MediaQuery.of(context).size.width * .6,
              height: 25,
            )
          : Text(
              title,
              style: TextStyle(
                  fontSize: _Consts.fontSizeTitle,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[700]),
            ),
    );
  }
}

class _FeaturedImage extends StatelessWidget {
  const _FeaturedImage({
    Key key,
    this.image,
    this.authorImage,
    placeholder,
    this.imageSize,
    this.authorImageSize,
    this.childMargin,
    circularAuthorImage,
  })  : this.placeholder = placeholder ?? false,
        this.circularAuthorImage = circularAuthorImage ?? false,
        super(key: key);

  final Widget image;
  final Widget authorImage;
  final bool placeholder;
  final double imageSize;
  final double authorImageSize;
  final EdgeInsets childMargin;
  final bool circularAuthorImage;

  @override
  Widget build(BuildContext context) {
    final _imageFatherSize = imageSize == null ? 100.0 : imageSize + 10;
    final _authorFatherImageSize =
        authorImageSize == null ? 30.0 : authorImageSize - 5;

    return Container(
      height: _imageFatherSize,
      width: _imageFatherSize,
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              height: imageSize ?? 80,
              width: imageSize ?? 80,
              color: Colors.grey[200],
              child: placeholder ? null : image,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: childMargin ?? EdgeInsets.only(left: 3, bottom: 3),
              width: _authorFatherImageSize,
              height: _authorFatherImageSize,
              decoration: BoxDecoration(
                shape:
                    circularAuthorImage ? BoxShape.circle : BoxShape.rectangle,
                color: Colors.white,
              ),
              child: Center(
                child: ClipOval(
                  child: Container(
                    width: authorImageSize ?? 25,
                    height: authorImageSize ?? 25,
                    color: Colors.grey[200],
                    child: placeholder ? null : authorImage,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

abstract class _Consts {
  static const paddingHorizontal = 20.0;
  static const paddingVertical = 10.0;
  static const fontSizeTitle = 18.0;
  static const titleRightPadding = 20.0;
}
