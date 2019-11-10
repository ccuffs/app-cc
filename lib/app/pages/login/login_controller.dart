import 'package:cc_uffs/app/pages/login/login_presenter.dart';
import 'package:cc_uffs/app/pages/login/login_response_observer.dart';
import 'package:cc_uffs/app/utils/default_controller.dart';
import 'package:cc_uffs/data/repositories/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigate/navigate.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginController extends DefaultController {
  LoginController() :
    presenter = LoginPresenter(AuthenticationRepository()),
    usernameFieldController = TextEditingController(),
    passwordFieldController = TextEditingController(),
    super();

  LoginPresenter presenter;
  TextEditingController passwordFieldController;
  TextEditingController usernameFieldController;

  LoginResponseObserver loginObserver;

  @override
  void initListeners() {
    loginObserver = LoginResponseObserver(controller: this);
  }

  Future<void> dontKnowId() async {
    const String url = 'https://id.uffs.edu.br/id/XUI/?realm=/#forgotUsername//';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // @TODO: Criar Exceptions que retornem erros legais pro user
      throw 'Could not launch $url';
    }
  }

  Future<void> forgetPassword() async {
    const String url = 'https://id.uffs.edu.br/id/XUI/?realm=/#passwordReset/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void loginUser() {
    createLoading();
    presenter.loginUser(usernameFieldController.text, passwordFieldController.text);
  }

  void navigateToHome() {
    navigateTo('home', ReplaceRoute.all);
  }
}