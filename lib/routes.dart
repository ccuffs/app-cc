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
}

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  RoutesNames.home: (BuildContext context) => HomeView(),
  RoutesNames.reader: (BuildContext context) => ReaderView(),
  RoutesNames.signIn: (BuildContext context) => LoginView(),
  RoutesNames.notifications: (BuildContext context) => NotificationsView(),
};
