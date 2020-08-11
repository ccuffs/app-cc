import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cc_uffs/models/user.dart';
import 'package:cc_uffs/services/user_service.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super();
  User _user;

  factory UserBloc.autoLogin() => UserBloc()..dispatch(UserEventTryAutoLogin());

  User get user {
    return _user;
  }

  bool get isAuth {
    return _user.authenticated;
  }

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UserEventTryAutoLogin) {
      yield UserInitial();
      await Future.delayed(Duration(seconds: 1));

      try {
        final user = await UserService.tryAutoLogin();
        if (user == null) {
          yield UserEventFirstUse();
        } else {
          _user = user;
          yield UserAutoLoginSuccess(user: user);
        }
      } catch (error) {
        yield UserAutoLoginError(
          message: 'Um erro ocorreu no autoLogin',
        );
      }
    }
    if (event is UserCreateLocalUser) {
      try {
        final User user = await UserService.createLocal();

        _user = user;

        yield UserAutoLoginSuccess(user: user);
      } on Exception catch (_) {
        yield UserAutoLoginError(
          message: 'Um erro ocorreu na criação do usuário local',
        );
      }
    }
    if (event is UserSignInEventSuccess) {
      _user = event.user;
      yield UserAutoLoginSuccess(user: user);
    }

    if (event is UserEventLogout) {
      _user = null;

      yield UserStateLogoutLoading();
      await Future.delayed(Duration(seconds: 1));

      try {
        final user = await UserService.createLocal();
        _user = user;
        yield UserAutoLoginSuccess(user: user);
      } catch (error) {
        yield UserAutoLoginError(
          message: 'Um erro ocorreu no login',
        );
      }
    }

    if (event is UserEventSignInSuccessFromRoute) {
      yield UserStateLoadingSigningIn();
      final user = event.user;
      _user = user;
      await Future.delayed(Duration(seconds: 1));

      yield UserAutoLoginSuccess(user: user);
    }
  }

  @override
  UserState get initialState => UserInitial();
}
