import 'package:cc_uffs/blocs/article_help/article_help_bloc.dart';
import 'package:cc_uffs/blocs/home_feed/home_feed_bloc.dart';
import 'package:cc_uffs/blocs/user/user_bloc.dart';
import 'package:cc_uffs/routes.dart';
import 'package:cc_uffs/screens/home/widgets/feed_content/feed_content_tab.dart';
import 'package:cc_uffs/screens/home/widgets/help_articles/help_articles_tab.dart';
import 'package:cc_uffs/shared/themes.dart';
import 'package:cc_uffs/shared/widgets/dialogButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/profile_widget/profile_widget.dart';

class HomeView extends StatelessWidget {
  static const routeName = "/home";

  const HomeView({Key key, userJustLoggedOut, userJustSignIn})
      : this.userJustLoggedOut = userJustLoggedOut ?? false,
        super(key: key);
  final bool userJustLoggedOut;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CC UFFS',
      // Todo: Change to user default theme
      theme: Themes.Options['default'],
      home: Home(loggedOutSign: userJustLoggedOut),
      routes: routes,
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key, this.loggedOutSign}) : super(key: key);
  final bool loggedOutSign;

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<Home> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    FeedContentTab(),
    Center(child: Text('Em construção', style: TextStyle(fontSize: 30))),
    HelpArticlesTab(),
    ProfileWidget(),
  ];

  static const _bottomBarItems = [
    {
      "icon": Icon(Icons.home),
      "title": Text('Home'),
    },
    {
      "icon": Icon(Icons.ac_unit),
      "title": Text('Placeholder'),
    },
    {
      "icon": Icon(Icons.help),
      "title": Text('Ajuda'),
    },
    {
      "icon": Icon(Icons.person, color: Colors.grey),
      "title": Text('Perfil'),
    }
  ];

  void _onItemTapped(int index) {
    // Prevent unauthenticated users to access some tabs
    if (!BlocProvider.of<UserBloc>(context).isAuth) {
      if (index == 3) {
        showCustomDialog(context, child: _LogoutDialog(context: context));
        return;
      }
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    // Todo: is this good enough? maybe display a more meaningful screen would be better
    if (!widget.loggedOutSign) return;
    _showDialogLoggedOut();
  }

  Future _showDialogLoggedOut() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog<String>(
        context: context,
        builder: (BuildContext context) => new AlertDialog(
          title: new Text("Você foi deslogado com sucesso"),
          // content: new Text("Message"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Continuar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<HomeFeedBloc>(
              create: (context) => HomeFeedBloc.fetchData()),
          BlocProvider<ArticleHelpBloc>(
            create: (context) => ArticleHelpBloc(),
          ),
        ],
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      //   create: (context) => HomeFeedBloc.fetchData(),
      //   child:,
      // ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).accentColor,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        elevation: 0,
        items: _bottomBarItems
            .map(
              (item) => BottomNavigationBarItem(
                icon: item['icon'],
                title: item['title'],
              ),
            )
            .toList(),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class _LogoutDialog extends StatelessWidget {
  const _LogoutDialog({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Text(
            'Você precisa se identificar para ter esse acesso a esse conteudo',
            style: TextStyle(fontSize: 22),
          ),
        ),
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: Themes.defaultTheme.primaryColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: SizedBox.expand(
            child: FlatButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(RoutesNames.signIn),
              child: Center(
                child: Text(
                  'ENTRAR',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
