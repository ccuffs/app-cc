import 'package:cc_uffs/app/pages/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:cc_uffs/theme/color.theme.dart' as AppColor;
import 'package:cc_uffs/pages/home.page.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColor.secondColor,
            ),
            child: ListTile(
              title: Center(
                child: ListTile(
                  title: Text(
                    "João das Neves",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  subtitle: Text(
                    "Bem-vindo!",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          // Notícias
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Notícias"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.push<MaterialPageRoute>(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          // Mensagens
          ListTile(
            leading: Icon(Icons.message),
            title: Text("Mensagens"),
            onTap: () {},
          ),
          // Enquetes
          ListTile(
            leading: Icon(Icons.poll),
            title: Text("Enquetes"),
            onTap: () {},
          ),
          // Laboratórios
          ListTile(
            leading: Icon(Icons.desktop_windows),
            title: Text("Laboratórios"),
            onTap: () {},
          ),
          // Calendário
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text("Calendário"),
            onTap: () {},
          ),
          // Divider
          Divider(
            color: Colors.black54,
            height: 36,
          ),
          // Configurações
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Configurações"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.arrow_back),
            title: Text("Acessar com outra conta"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.push<MaterialPageRoute>(context,
                  MaterialPageRoute(builder: (context) => LoginView()));
            },
          ),
        ],
      ),
    );
  }
}
