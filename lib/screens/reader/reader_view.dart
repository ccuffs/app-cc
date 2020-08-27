import 'package:cached_network_image/cached_network_image.dart';
import 'package:cc_uffs/blocs/reader/reader_bloc.dart';
import 'package:cc_uffs/shared/widgets/custom_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_cc_parser/site_cc_parser.dart';

class ReaderView extends StatefulWidget {
  static const routeName = "/reader";
  @override
  _ReaderViewState createState() => _ReaderViewState();
}

class _ReaderViewState extends State<ReaderView> {
  double _fontSizeFactor = 0;
  double _lastPosition = 0;

  bool _bar = true;
  ParserSiteResponse item;
  bool _firstBuild = true;

  ScrollController _controller;

  void _changeFontSize({@required bool add}) {
    double newFontFactor;

    if (add && _fontSizeFactor < 4) {
      newFontFactor = _fontSizeFactor + 2;
    } else if (!add && _fontSizeFactor > -8)
      newFontFactor = _fontSizeFactor - 2;

    if (newFontFactor == null) return;

    setState(() {
      _fontSizeFactor = newFontFactor;
    });
  }

  _scrollListener() async {
    if (_lastPosition - _controller.offset >= 2 && !_bar)
      setState(() => _bar = true);
    else if (_lastPosition - _controller.offset < 0 && _bar)
      setState(() => _bar = false);

    _lastPosition = _controller.offset;
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);

    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_firstBuild) return;
    _firstBuild = false;

    item = ModalRoute.of(context).settings.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<ReaderBloc>(
        create: (context) => ReaderBloc.dispatchFetch(item),
        child: Stack(
          children: <Widget>[
            CustomScrollView(
              controller: _controller,
              slivers: [
                CustomSliverAppBar(
                  pinned: false,
                  snap: false,
                  floating: true,
                  showNotifications: false,
                ),
                BlocBuilder<ReaderBloc, ReaderState>(
                  builder: (context, state) {
                    if (state is ReaderStateContentSuccess)
                      return _Reader(
                        fontSizeFactor: _fontSizeFactor,
                        item: state.item,
                      );
                    else if (state is ReaderStateContentLoading)
                      return SliverToBoxAdapter(
                          child: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Center(child: CircularProgressIndicator()),
                      ));
                    else // Todo: implement a better error Return
                      return SliverToBoxAdapter(
                          child: Center(child: Text('Um erro ocorreu')));
                  },
                ),
              ],
            ),
            AnimatedOpacity(
              opacity: _bar ? 1.0 : 0.0,
              duration: Duration(milliseconds: 200),
              child: _BottomBar(changeFontSize: _changeFontSize),
            ),
          ],
        ),
      ),
    );
  }
}

class _Reader extends StatelessWidget {
  const _Reader({
    Key key,
    @required this.item,
    @required this.fontSizeFactor,
  }) : super(key: key);

  final double fontSizeFactor;
  final ParserSiteResponse item;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            _Title(
              title: item.title,
              fontFactor: fontSizeFactor,
            ),
            _AuthorSection(
              date: DateTime.now(),
              authorName: item.author,
              photo: item.authorImage,
              readingTime: '15',
            ),
            _FeaturedImage(
              imageUrl: item.image,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...item.htmlContent.items.map((item) {
                  switch (item.keys.first) {
                    case HtmlParsed.p:
                      return _DefaultText(
                        fontSize: _Consts.fontSize,
                        text: item[HtmlParsed.p],
                        fontFactor: fontSizeFactor,
                      );
                    case HtmlParsed.h4:
                      return _SessionTitle(
                        title: item[HtmlParsed.h4],
                        fontFactor: fontSizeFactor,
                      );

                    case HtmlParsed.img:
                      return _DisplayImage(imageUrl: item[HtmlParsed.img]);

                    case HtmlParsed.video:
                      return _DisplayVideo(
                        videoUrl: item[HtmlParsed.video],
                      );

                    default:
                      return Container();
                  }
                }).toList(),
                SizedBox(height: 100),
                _Footer()
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({
    Key key,
  }) : super(key: key);

  //Todo: implement 'related content'
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    this.changeFontSize,
    Key key,
  }) : super(key: key);

  final Function changeFontSize;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        width: double.infinity,
        height: 50,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: Color(0xFFfcae17),
              ),
              onPressed: null,
            ),
            IconButton(
              icon: Icon(
                Icons.share,
                color: Color(0xFFfcae17),
              ),
              onPressed: null,
            ),
            Expanded(child: Container()),
            IconButton(
              icon: Icon(
                Icons.format_size,
                color: Color(0xFFfcae17),
              ),
              onPressed: () {
                changeFontSize(add: false);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.format_size,
                color: Color(0xFFfcae17),
              ),
              onPressed: () {
                changeFontSize(add: true);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FeaturedImage extends StatelessWidget {
  const _FeaturedImage({
    Key key,
    @required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: _Consts.paddingVertical),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.fitWidth,
        height: MediaQuery.of(context).size.height * .28,
        width: double.infinity,
        placeholder: (context, url) => Container(color: Colors.grey[200]),
      ),
    );
  }
}

class _AuthorSection extends StatelessWidget {
  const _AuthorSection({
    Key key,
    @required this.authorName,
    @required this.photo,
    @required this.date,
    @required this.readingTime,
  }) : super(key: key);

  final String authorName;
  final String photo;
  final DateTime date;
  final String readingTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: _Consts.paddingHorizontal,
        vertical: _Consts.paddingVertical,
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
              color: Colors.grey[200],
              height: 20,
              width: 20,
              child: CachedNetworkImage(
                imageUrl: photo,
                placeholder: (context, url) =>
                    Container(color: Colors.grey[200]),
              ),
            ),
          ),
          SizedBox(width: 10),
          Text(authorName),
          SizedBox(width: 10),
          Text('18 de dez, 2018'),
          SizedBox(width: 8),
          Expanded(
              child: Text(
            readingTime + 'min de leitura',
            overflow: TextOverflow.ellipsis,
          )),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    this.title,
    this.fontFactor,
    Key key,
  }) : super(key: key);

  final String title;
  final double fontFactor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: _Consts.paddingVertical,
        horizontal: _Consts.paddingHorizontal,
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: 28 + fontFactor),
      ),
    );
  }
}

class _DisplayVideo extends StatelessWidget {
  const _DisplayVideo({
    Key key,
    @required this.videoUrl,
  }) : super(key: key);

  final String videoUrl;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _DisplayImage extends StatelessWidget {
  const _DisplayImage({
    Key key,
    this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: _Consts.paddingVertical + 10),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.fitWidth,
        placeholder: (context, url) => Container(color: Colors.grey[200]),
      ),
    );
  }
}

class _SessionTitle extends StatelessWidget {
  const _SessionTitle({
    this.fontFactor,
    this.title,
    Key key,
  }) : super(key: key);

  final double fontFactor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: _Consts.paddingHorizontal,
        vertical: _Consts.paddingVertical,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: _Consts.fontSizeSession + fontFactor,
        ),
      ),
    );
  }
}

class _DefaultText extends StatelessWidget {
  const _DefaultText({
    Key key,
    @required this.text,
    @required this.fontSize,
    @required this.fontFactor,
  }) : super(key: key);

  final String text;
  final double fontSize;
  final double fontFactor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: _Consts.paddingHorizontal,
        vertical: _Consts.paddingVertical,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize + fontFactor,
          height: _Consts.letterHeight,
        ),
      ),
    );
  }
}

class _Consts {
  static const paddingHorizontal = 16.0;
  static const paddingVertical = 10.0;
  static const fontSize = 18.5;
  static const fontSizeSession = 25;
  static const letterHeight = 1.7;
}
