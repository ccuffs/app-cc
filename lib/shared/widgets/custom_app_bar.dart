import 'package:cc_uffs/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dynamic CustomAppBar({bottom}) {
  return AppBar(
    backgroundColor: Color(0xFF343433),
    elevation: 0,
    title: Row(
      children: <Widget>[
        Image.asset(
          ImageAssets.logo,
          width: 40,
          height: 30,
        ),
        SizedBox(width: 5),
        Text('Ciência da Computação')
      ],
    ),
    bottom: bottom,
  );
}
