import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginController extends Controller {
  LoginController() : super(LoginPresenter(AuthenticationRepository()));
  TextEditingController passwordFieldController;
  TextEditingController emailFieldController;

  @override
  void initListeners() {
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
    presenter.loginUser();
  }
}