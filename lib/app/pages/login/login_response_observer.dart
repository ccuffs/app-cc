import 'package:cc_uffs/app/pages/login/login_controller.dart';
import 'package:cc_uffs/app/utils/default_observer.dart';
import 'package:cc_uffs/domain/entities/user.dart';
import 'package:cc_uffs/domain/exceptions/uffs_exceptions.dart';
import 'package:cc_uffs/session.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

// Isso não realmente existe na arquitetura, eu utilizo assim pois acredito que torna mais facil se achar
// E mantem uma organizacao, pois assim centralizamos as respostas,
// na arquitetura original as funcoes de complete next e error ficariam dentro do controller
// e no initListener do controller fariamos presenter.loginOnComplete = onLoginComplete; e assim por diante
// Vejam oq acham, comentem no pull, dependendo do q acharem seguimos assim, ou fazemos no controller
class LoginResponseObserver {
  LoginResponseObserver({this.controller}) {
    controller.presenter.loginObserver = DefaultObserver<User>(completeCallback: onLoginComplete, errorCallback: onLoginError, nextCallback: onLoginNext);
  }

  LoginController controller;

  User user;
  
  void onLoginComplete() {
    Session.user = user;
    controller.disposeLoading();
    controller.isLoading = false;
    controller.navigateToHome();
  }

  void onLoginError(Exception e) {
    controller.isLoading = false;
    controller.disposeLoading();
    if (e is UffsExceptions) {
      controller.createDialog(title: 'Erro no login!', body: e.message, button: 'OK');
    }
  }

  void onLoginNext(dynamic response) {
    user = response;
  }

}