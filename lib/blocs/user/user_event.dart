part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserEventTryAutoLogin extends UserEvent {
  List<Object> get props => [];
}

class UserEventCreateLocalUser extends UserEvent {
  List<Object> get props => [];
}

class UserEventSignInSuccess extends UserEvent {
  final User user;

  UserEventSignInSuccess({this.user});

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
