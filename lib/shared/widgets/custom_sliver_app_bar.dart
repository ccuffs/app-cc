import 'package:cc_uffs/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    Key key,
    this.bottom,
    pinned: true,
    snap: false,
    floating: true,
  })  : this.pinned = pinned,
        this.snap = snap,
        this.floating = floating,
        super(key: key);

  final Widget bottom;
  final bool pinned;
  final bool snap;
  final bool floating;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: floating,
      pinned: pinned,
      backgroundColor: Color(0xFF343433),
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
}
