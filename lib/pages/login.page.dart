import 'package:flutter/material.dart';
import 'package:cc_uffs/theme/color.theme.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primaryColor,
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.only(top: 50,left: 20,right: 20,bottom: 40),
          padding: EdgeInsets.only(top: 0,left: 30,right: 30,bottom: 0),
          child: ListView(
            children: <Widget>[
              // LOGO 
              SizedBox(
                height: 128,
                child: Image.asset("assets/imgs/logo-verde.png"),
              ),
              SizedBox(height: 5),
              // IdUFFS
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "IdUFFS ou CPF",
                  labelStyle: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  )
                ),
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              // Senha
              TextFormField(
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Senha",
                  labelStyle: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  )
                ),
                style: TextStyle(fontSize: 20),
              ),
              Container(
                // height: 40,
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        "Não sei meu IdUFFS",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      onPressed: () async {
                        const url = 'https://id.uffs.edu.br/id/XUI/?realm=/#forgotUsername//';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    ),
                    // SizedBox(width: 10),
                    FlatButton(
                      child: Text(
                        "Esqueci a senha",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      onPressed: () async {
                        const url = 'https://id.uffs.edu.br/id/XUI/?realm=/#passwordReset/';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              // Botão de Login
              Container(
                height: 60,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Color(0xFFF519387),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: SizedBox.expand(
                  child: FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'ENTRAR',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () => {}
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}