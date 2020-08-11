part of 'home_feed_bloc.dart';

abstract class HomeFeedState extends Equatable {
  const HomeFeedState();
}

class HomeFeedInitial extends HomeFeedState {
  @override
  List<Object> get props => [];
}

class HomeFeedSuccessFetching extends HomeFeedState {
  final HomeContentResponse homeContent;

  HomeFeedSuccessFetching(this.homeContent);

  @override
  List<Object> get props => [homeContent];
}

class HomeFeedError extends HomeFeedState {
  final String message;

  HomeFeedError({this.message});
  @override
  List<Object> get props => [message];
}
