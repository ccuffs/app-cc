import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.only(top: 60,left: 40,right: 40,),
          
        ),
      ),
    );
  }
}