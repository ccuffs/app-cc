import 'package:cc_uffs/app/pages/login/login_controller.dart';
import 'package:cc_uffs/app/utils/default_view.dart';
import 'package:cc_uffs/theme/app_cc_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class LoginView extends View {
 
  @override
  State<StatefulWidget> createState() {
    return LoginViewState(LoginController());
  }

}

class LoginViewState extends DefaultViewState<LoginView, LoginController> {
  LoginViewState(Controller controller) : super(controller);

  @override
  Widget defaultBuild(BuildContext context) {
    return Scaffold(
      key: globalKey,
      body: Container(
        color: AppColors.primaryColor,
        child: Container(
          color: Colors.white,
          margin: const EdgeInsets.only(top: 50,left: 20,right: 20,bottom: 40),
          padding: const EdgeInsets.only(top: 0,left: 30,right: 30,bottom: 0),
          child: ListView(
            children: <Widget>[
              // LOGO
              SizedBox(
                height: 128,
                child: Image.asset('assets/imgs/logo-verde.png'),
              ),
              const SizedBox(height: 5),
              // IdUFFS
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: controller.usernameFieldController,
                decoration: InputDecoration(
                  labelText: 'IdUFFS ou CPF',
                  labelStyle: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  )
                ),
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              // Senha
              TextFormField(
                keyboardType: TextInputType.text,
                obscureText: true,
                controller: controller.passwordFieldController,
                decoration: InputDecoration(
                  labelText: 'Senha',
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
                        'Não sei meu IdUFFS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      onPressed: controller.dontKnowId
                    ),
                    // SizedBox(width: 10),
                    FlatButton(
                      child: Text(
                        'Esqueci a senha',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      onPressed: controller.forgetPassword
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // Botão de Login
              Container(
                height: 60,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: const Color(0xFFF519387),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: SizedBox.expand(
                  child: FlatButton(
                    onPressed: controller.loginUser,
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
