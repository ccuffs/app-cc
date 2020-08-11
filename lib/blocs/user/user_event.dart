part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserEventTryAutoLogin extends UserEvent {
  List<Object> get props => [];
}

class UserCreateLocalUser extends UserEvent {
  List<Object> get props => [];
}

class UserSignInEventSuccess extends UserEvent {
  final User user;

  UserSignInEventSuccess({this.user});

  @override
  List<Object> get props => [user];
}

class UserEventLogout extends UserEvent {
  UserEventLogout();

  @override
  List<Object> get props => [];
}

class UserEventSignInSuccessFromRoute extends UserEvent {
  final User user;

  UserEventSignInSuccessFromRoute({this.user});

  @override
  List<Object> get props => [user];
}
