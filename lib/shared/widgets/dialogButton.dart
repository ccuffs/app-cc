import 'package:flutter/material.dart';

void showCustomDialog(
  context, {
  @required child,
}) {
  showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 300),
    context: context,
    pageBuilder: (_, __, ___) => Align(
      alignment: Alignment.bottomCenter,
      child: Material(
        child: Container(
          height: 200,
          child: SizedBox.expand(child: child),
          margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
        ),
      ),
    ),
    transitionBuilder: (_, anim, __, child) => SlideTransition(
      position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
      child: child,
    ),
  );
}
