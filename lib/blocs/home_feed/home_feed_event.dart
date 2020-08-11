part of 'home_feed_bloc.dart';

abstract class HomeFeedEvent extends Equatable {
  const HomeFeedEvent();
}

class FetchDataEvent extends HomeFeedEvent {
  static const NEWS = 'news';
  static const POSTS = 'posts';
  static const VACANCIES = 'vancancies';

  final String option;

  FetchDataEvent({this.option});

  @override
  List<Object> get props => [option];
}
