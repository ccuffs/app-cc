part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();
}

class SignInInitial extends SignInState {
  @override
  List<Object> get props => [];
}

class LoadingSignInState extends SignInState {
  @override
  List<Object> get props => [];
}

class SuccessSignInState extends SignInState {
  final User user;

  SuccessSignInState(this.user);
  @override
  List<Object> get props => [user];
}

class ErrorSignInState extends SignInState {
  final String message;

  ErrorSignInState(this.message);
  @override
  List<Object> get props => [message];
}
