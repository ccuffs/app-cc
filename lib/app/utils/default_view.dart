import 'package:cc_uffs/app/utils/default_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

abstract class DefaultViewState<view extends View, defaultController extends DefaultController> extends ViewState<view, defaultController> {
  DefaultViewState(DefaultController defaultController) : super(defaultController);

  Widget defaultBuild(BuildContext context);

  Widget loadingBuild(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: defaultBuild(context)
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black.withOpacity(0.55),
          )
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(
            child: createLoadingIndicator()
          )
        )
      ]
    );
  }

  
  SpinKitWave createLoadingIndicator([double size = 50.0, Color color = Colors.white]) {
    return SpinKitWave(
      color: color,
      size: size
    );
  }

  Widget errorBuild(BuildContext context) {
    return Scaffold(
      key: globalKey,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: const Text('Super erro')
        )
      )
    );
  }

  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    if (controller.hasError) {
      return errorBuild(context);
    } else if (controller.isLoading) {
      return loadingBuild(context);
    }
    return defaultBuild(context);
  }
}