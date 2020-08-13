import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cc_uffs/models/user.dart';
import 'package:cc_uffs/services/user_service.dart';
import 'package:equatable/equatable.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInStateInitial());

  @override
  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    if (event is UserSignInEvent) {
      yield SignInStateLoading();

      try {
        final user =
            await UserService.authenticate(event.authenticator, event.password);
        if (user == null)
          yield SignInStateError('Usuário ou senha errados');
        else
          yield SignInStateSuccess(user);
      } catch (error) {
        yield SignInStateError('Um erro inesperado ocorreu');
      }
    }
    if (state is SignInLoading) yield SignInStateLoading();
  }
}
