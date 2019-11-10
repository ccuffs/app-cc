import 'package:cc_uffs/app/pages/login/login_view.dart';
import 'package:cc_uffs/app/utils/app_drawer_controller.dart';
import 'package:cc_uffs/session.dart';
import 'package:cc_uffs/theme/app_cc_colors.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({this.controller});

  final AppDrawerController controller;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.secondColor,
            ),
            child: ListTile(
              title: Center(
                child: ListTile(
                  title: Text(Session.user.name, style: TextStyle(color: Colors.white, fontSize: 22)),
                  subtitle: Text('Bem-vindo!', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ),
          // Notícias
          ListTile(
            leading: Icon(Icons.home),
            title: const Text('Notícias'),
            onTap: () => controller.navigateTo('notices'),
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
