import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:site_cc_parser/site_cc_parser.dart';

part 'reader_event.dart';
part 'reader_state.dart';

class ReaderBloc extends Bloc<ReaderEvent, ReaderState> {
  ReaderBloc() : super();

  factory ReaderBloc.dispatchFetch(ParserSiteResponse item) =>
      ReaderBloc()..dispatch(FetchUrlEvent(item: item));

  @override
  Stream<ReaderState> mapEventToState(
    ReaderEvent event,
  ) async* {
    if (event is FetchUrlEvent) {
      if (event.item.htmlContent != null)
        yield ReaderStateContentSuccess(item: event.item);
      else {
        yield ReaderStateContentLoading();

        try {
          final pageFetch = await event.item.fetchUrlContent();
          if (pageFetch == true)
            yield ReaderStateContentSuccess(item: event.item);
          else
            yield ReaderStateContentError(
                message: 'Página não pode ser acessada');
        } catch (error) {
          yield ReaderStateContentError(
              message: 'Um erro desconhecido ocorreu');
        }
      }
    }
  }

  @override
  ReaderState get initialState => ReaderInitial();
}
