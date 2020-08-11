import 'package:cc_uffs/screens/home/home_view.dart';
import 'package:cc_uffs/screens/login/login_view.dart';
import 'package:cc_uffs/screens/reader/reader.dart';
import 'package:flutter/widgets.dart';

abstract class RoutesNames {
  static const home = HomeView.routeName;
  static const reader = Reader.routeName;
  static const signIn = LoginView.routeName;
}

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  RoutesNames.home: (BuildContext context) => Home(),
  RoutesNames.reader: (BuildContext context) => Reader(),
  RoutesNames.signIn: (BuildContext context) => LoginView(),
};
