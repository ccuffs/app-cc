import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).secondaryHeaderColor,
            ),
            child: ListTile(
              title: Center(
                child: ListTile(
                  subtitle:
                      Text('Bem-vindo!', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: const Text('Notícias'),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text("Mensagens"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.poll),
            title: Text("Enquetes"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.desktop_windows),
            title: Text("Laboratórios"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text("Calendário"),
            onTap: () {},
          ),
          Divider(
            color: Colors.black54,
            height: 36,
          ),
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
            },
          ),
        ],
      ),
    );
  }
}
