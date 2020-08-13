part of 'home_feed_bloc.dart';

abstract class HomeFeedState extends Equatable {
  const HomeFeedState();
}

class HomeFeedStateInitial extends HomeFeedState {
  @override
  List<Object> get props => [];
}

class HomeFeedStateSuccessFetching extends HomeFeedState {
  final HomeContentResponse homeContent;

  HomeFeedStateSuccessFetching(this.homeContent);

  @override
  List<Object> get props => [homeContent];
}

class HomeFeedStateError extends HomeFeedState {
  final String message;

  HomeFeedStateError({this.message});
  @override
  List<Object> get props => [message];
}
