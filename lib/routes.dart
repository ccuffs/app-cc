import 'package:cc_uffs/screens/help/category_items_view.dart';
import 'package:cc_uffs/screens/help/help_article_view.dart';
import 'package:cc_uffs/screens/help/search_article_help_view.dart';
import 'package:cc_uffs/screens/home/home_view.dart';
import 'package:cc_uffs/screens/login/login_view.dart';
import 'package:cc_uffs/screens/notifications/notifications_view.dart';
import 'package:cc_uffs/screens/reader/reader_view.dart';
import 'package:flutter/widgets.dart';

abstract class RoutesNames {
  static const home = HomeView.routeName;
  static const reader = ReaderView.routeName;
  static const signIn = LoginView.routeName;
  static const notifications = NotificationsView.routeName;
  static const helpCategory = CategoryItemView.routeName;
  static const helpArticle = HelpArticleView.routeName;
  static const helpArticleSearch = SearchArticleHelpView.routeName;
}

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  RoutesNames.home: (BuildContext context) => HomeView(),
  RoutesNames.reader: (BuildContext context) => ReaderView(),
  RoutesNames.signIn: (BuildContext context) => LoginView(),
  RoutesNames.notifications: (BuildContext context) => NotificationsView(),
  RoutesNames.helpCategory: (context) => CategoryItemView(),
  RoutesNames.helpArticle: (context) => HelpArticleView(),
  RoutesNames.helpArticleSearch: (context) => SearchArticleHelpView(),
};
