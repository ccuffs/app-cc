import 'package:cc_uffs/shared/constants.dart';
import 'package:cc_uffs/shared/themes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(40),
        color: Themes.defaultTheme.primaryColor,
        child: Center(
          child: Image.asset(ImageAssets.fullLogo),
        ),
      ),
    );
  }
}
