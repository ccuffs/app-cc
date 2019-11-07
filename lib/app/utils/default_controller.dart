import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:navigate/navigate.dart';

abstract class DefaultController extends Controller {

  bool hasError = false;

  void createLoading() => showLoading();

  void disposeLoading() => dismissLoading();

  void navigatorPop() {
    Navigator.of(getContext()).pop();
  }

  void navigateTo(String routeName, [ReplaceRoute replaceRoute = ReplaceRoute.none]) {
    Navigate.navigate(getContext(), routeName);
  }

  void createDialog({String title, String body, String button}) {
    showDialog<Widget>(
      context: getContext(),
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row (
            children: <Widget>[
              Flexible(
                child: Padding (
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.title.apply(fontWeightDelta: -1, fontSizeFactor: 0.9),
                  )
                ),
              )
            ]
          ),
          contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 5.0),
          content: Container(
            child: SingleChildScrollView (
              physics: const BouncingScrollPhysics(),
              child: Text (
                body,
                style: Theme.of(context).textTheme.body1
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton (
              onPressed: () => Navigator.pop(context),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text (
                  button,
                  style: Theme.of(context).textTheme.body1.apply(
                    color: Theme.of(context).primaryColor,
                    fontWeightDelta: 1,
                  ),
                ),
              )
            )
          ],
        );
      } 
    );
  }

}