part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();
}

class UserSignInEvent extends SignInEvent {
  final String authenticator;
  final String password;

  UserSignInEvent({this.authenticator, this.password});

  @override
  List<Object> get props => [authenticator, password];
}

class SignInLoading extends SignInEvent {
  @override
  List<Object> get props => [];
}
