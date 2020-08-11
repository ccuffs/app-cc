import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cc_uffs/services/site_cc_service.dart';
import 'package:equatable/equatable.dart';

part 'home_feed_event.dart';
part 'home_feed_state.dart';

class HomeFeedBloc extends Bloc<HomeFeedEvent, HomeFeedState> {
  HomeFeedBloc() : super();

  factory HomeFeedBloc.dispatch() => HomeFeedBloc()..dispatch(FetchDataEvent());

  @override
  Stream<HomeFeedState> mapEventToState(
    HomeFeedEvent event,
  ) async* {
    if (event is FetchDataEvent) {
      try {
        final data = await SiteCCService.fetchHomePage();

        yield HomeFeedSuccessFetching(data);
      } catch (error) {
        yield HomeFeedError(message: "Um erro estranho ocorreu");
      }
    }
  }

  @override
  HomeFeedState get initialState => HomeFeedInitial();
}
