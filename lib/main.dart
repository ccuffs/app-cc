// import 'package:cc_uffs/pages/home.page.dart';
import 'package:cc_uffs/pages/login.page.dart';
import 'package:cc_uffs/theme/color.theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // Padrões de Cores da UFFS
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: primaryColor,
        secondaryHeaderColor: secondColor,
      ),
      home: LoginPage(),
    );
  }
}
