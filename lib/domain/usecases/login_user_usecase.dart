import 'dart:async';
import 'dart:convert';

import 'package:cc_uffs/data/repositories/authentication_repository.dart';
import 'package:cc_uffs/domain/entities/server_response.dart';
import 'package:cc_uffs/domain/entities/user.dart';
import 'package:cc_uffs/domain/exceptions/api_exception.dart';
import 'package:cc_uffs/domain/exceptions/user_not_found_exception.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:pedantic/pedantic.dart';
import 'package:rxdart/rxdart.dart';

class LoginUserUseCase extends CompletableUseCase<LoginUseCaseParams> {
  LoginUserUseCase(this._authenticationRepository);

  final AuthenticationRepository _authenticationRepository;

  @override
  Future<Observable<User>> buildUseCaseObservable(LoginUseCaseParams params) async {
    final StreamController<User> controller = StreamController<User>();
    try {
      final ServerResponse response = await _authenticationRepository.authenticate(username: params.username, password: params.password);
      switch (response.statusCode) {
        case 200:
          final User user = User.fromJson(json.decode(response.data));
          controller.add(user);
          unawaited(controller.close());
          break;
        case 401:
        case 403:
        case 404:
          throw UserNotFoundException();
          break;
        default:
          throw ApiException();
          break;
      }
    } catch (e) {
      controller.addError(e);
    }
    return Observable<User>(controller.stream);
  }
}

class LoginUseCaseParams {
  LoginUseCaseParams(this.username, this.password);

  final String username;
  final String password;
}