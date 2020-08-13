part of 'direct_message_bloc.dart';

@immutable
abstract class DirectMessageEvent extends Equatable {}

class DirectMessageEventFetchMessages extends DirectMessageEvent {
  @override
  List<Object> get props => [];
}
