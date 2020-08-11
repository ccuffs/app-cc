part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserAutoLoginSuccess extends UserState {
  UserAutoLoginSuccess({this.user});

  final User user;

  @override
  List<Object> get props => [user];
}

class UserAutoLoginError extends UserState {
  UserAutoLoginError({this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

class UserEventFirstUse extends UserState {
  List<Object> get props => [];
}

class UserStateLogoutSuccess extends UserState {
  List<Object> get props => [];
}

class UserStateLogoutLoading extends UserState {
  List<Object> get props => [];
}


class UserStateLogoutError extends UserState {
  List<Object> get props => [];
}

class UserStateSignInSuccessFromRoute extends UserState {
  List<Object> get props => [];
}

class UserStateLoadingSigningIn extends UserState {
  List<Object> get props => [];
}
