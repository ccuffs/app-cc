import 'package:flutter/material.dart';

abstract class Themes {
  static const DarkGreen = 'darkGreen';
  static const Darker = 'darker';
  static const Default = 'default';

  static ThemeData get darkGreen => Themes.Options[DarkGreen];
  static ThemeData get darker => Themes.Options[Darker];
  static ThemeData get defaultTheme => Themes.Options[Default];

  static final Options = {
    Themes.DarkGreen: ThemeData(
      primaryColor: Color(0xFF00693E),
      secondaryHeaderColor: Color(0xFF008F45),
      accentColor: Color(0xFF9ECD18),
    ),
    Themes.Darker: ThemeData(
      primaryColor: Colors.lightBlueAccent,
      secondaryHeaderColor: Colors.blueAccent,
      accentColor: Colors.blueAccent,
      brightness: Brightness.dark,
    ),
    Themes.Default: ThemeData(
      primaryColor: Color(0xFF343433),
      accentColor: Color(0xFF76d7c4),
    ),
  };
}
