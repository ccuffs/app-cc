import 'package:cc_uffs/app/pages/home/home_controller.dart';
import 'package:cc_uffs/app/widgets/drawer.dart';
import 'package:cc_uffs/theme/app_cc_colors.dart';
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
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text('Notícias'),
      ),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
          ),
          children: <Widget>[
            Card(
              child: InkWell(
                onTap: () {},
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.network('https://cc.uffs.edu.br/images/posts/teaser-sacc-400x250.jpg'),
                    ListTile(
                      title: const Text('Semana Acadêmica Ciência da Computação 2019'),
                      subtitle: const Text('16 de Outubro de 2019'),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: InkWell(
                onTap: () {},
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.network('https://cc.uffs.edu.br/images/posts/teaser-aviso-1800x600.jpg'),
                    ListTile(
                      title: const Text('Ato deliberativo sobre carga horária mínima'),
                      subtitle: const Text('15 de Outubro de 2019'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}