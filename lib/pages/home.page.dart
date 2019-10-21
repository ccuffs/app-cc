import 'package:flutter/material.dart';
import 'package:cc_uffs/theme/color.theme.dart' as AppColor;
import 'package:cc_uffs/components/appdrawer.component.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: Text("Notícias"),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.only(
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
                    Image.network(
                        "https://cc.uffs.edu.br/images/posts/teaser-sacc-400x250.jpg"),
                    ListTile(
                      title:
                          Text("Semana Acadêmica Ciência da Computação 2019"),
                      subtitle: Text("16 de Outubro de 2019"),
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
                    Image.network(
                        "https://cc.uffs.edu.br/images/posts/teaser-aviso-1800x600.jpg"),
                    ListTile(
                      title:
                          Text("Ato deliberativo sobre carga horária mínima"),
                      subtitle: Text("15 de Outubro de 2019"),
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
