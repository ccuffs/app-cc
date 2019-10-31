import 'package:cc_uffs/app/utils/default_observer.dart';
import 'package:cc_uffs/domain/entities/user.dart';
import 'package:cc_uffs/domain/repositories/authentication_repository.dart';
import 'package:cc_uffs/domain/usecases/login_user_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class LoginPresenter extends Presenter {
  LoginPresenter(AuthenticationRepository authenticationRepository) : loginUserUseCase = LoginUserUseCase(authenticationRepository);

  LoginUserUseCase loginUserUseCase;
  DefaultObserver<User> loginObserver;

  @override
  void dispose() {
  }

  void loginUser(String username, String password) {
    loginUserUseCase.execute(loginObserver, LoginUseCaseParams(username, password));
  }
}