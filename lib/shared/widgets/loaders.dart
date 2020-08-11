import 'package:flutter/material.dart';

class SignInUserLoader extends StatelessWidget {
  const SignInUserLoader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(child: Center(child: CircularProgressIndicator()));
  }
}

class SignOutUserLoader extends StatelessWidget {
  const SignOutUserLoader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(child: Center(child: CircularProgressIndicator()));
  }
}
