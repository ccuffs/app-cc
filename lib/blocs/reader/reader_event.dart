part of 'reader_bloc.dart';

abstract class ReaderEvent extends Equatable {
  const ReaderEvent();
}

class FetchUrlEvent extends ReaderEvent {
  final ParserSiteResponse item;

  FetchUrlEvent({this.item});

  @override
  List<Object> get props => [item];
}
