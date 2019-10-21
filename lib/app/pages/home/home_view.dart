import 'package:cc_uffs/app/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class HomeView extends View {
  @override
  State<StatefulWidget> createState() {
    return HomeViewState(HomeController());
  }
}

class HomeViewState extends ViewState<HomeView, HomeController> {
  HomeViewState(Controller controller) : super(controller);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.only(top: 60,left: 40,right: 40,),
          
        ),
      ),
    );
  }
}