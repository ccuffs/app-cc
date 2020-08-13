part of 'direct_message_bloc.dart';

@immutable
abstract class DirectMessageState extends Equatable {}

class DirectMessageLoadingState extends DirectMessageState {
  @override
  List<Object> get props => [];
}

class DirectMessageSuccessState extends DirectMessageState {
  final List<DirectMessage> messages;

  DirectMessageSuccessState({
    @required this.messages,
  });

  @override
  List<Object> get props => [messages];
}

class DirectMessageErrorState extends DirectMessageState {
  final String error;

  DirectMessageErrorState({this.error});

  @override
  List<Object> get props => [error];
}
