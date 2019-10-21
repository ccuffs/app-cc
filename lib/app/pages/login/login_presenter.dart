import 'package:cc_uffs/domain/repositories/authentication_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class LoginPresenter extends Presenter {
  LoginPresenter([this.authenticationRepository]);

  AuthenticationRepository authenticationRepository;

  @override
  void dispose() {
  }

  void loginUser() {
    
  }
  
}