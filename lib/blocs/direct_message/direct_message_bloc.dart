import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cc_uffs/services/direct_messages_service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'direct_message_event.dart';
part 'direct_message_state.dart';

class DirectMessageBloc extends Bloc<DirectMessageEvent, DirectMessageState> {
  DirectMessageBloc() : super(DirectMessageLoadingState());
  var _directMessages;

  dynamic get getDirectMessages {
    return [..._directMessages];
  }

  factory DirectMessageBloc.buildAndFetch() =>
      DirectMessageBloc()..add(DirectMessageEventFetchMessages());

  @override
  Stream<DirectMessageState> mapEventToState(DirectMessageEvent event) async* {
    if (event is DirectMessageEventFetchMessages) {
      if (_directMessages != null) {
        yield DirectMessageSuccessState(messages: [..._directMessages]);
      } else {
        try {
          final directMessages = await DirectMessages.fetchFromServer();
          _directMessages = directMessages;

          yield DirectMessageSuccessState(messages: [...directMessages]);
        } catch (error) {
          yield DirectMessageErrorState(error: 'Um erro estranho ocorreu');
        }
      }
    }
  }
}
