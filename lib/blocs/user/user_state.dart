part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserStateInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserStateAutoLoginSuccess extends UserState {
  UserStateAutoLoginSuccess({this.user});

  final User user;

  @override
  List<Object> get props => [user];
}

class UserStateAutoLoginError extends UserState {
  UserStateAutoLoginError({this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

class UserStateFirstUse extends UserState {
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
