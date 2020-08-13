part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();
}

class SignInStateInitial extends SignInState {
  @override
  List<Object> get props => [];
}

class SignInStateLoading extends SignInState {
  @override
  List<Object> get props => [];
}

class SignInStateSuccess extends SignInState {
  final User user;

  SignInStateSuccess(this.user);
  @override
  List<Object> get props => [user];
}

class SignInStateError extends SignInState {
  final String message;

  SignInStateError(this.message);
  @override
  List<Object> get props => [message];
}
