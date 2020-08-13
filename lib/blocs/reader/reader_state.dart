part of 'reader_bloc.dart';

abstract class ReaderState extends Equatable {
  const ReaderState();
}

class ReaderStateInitial extends ReaderState {
  @override
  List<Object> get props => [];
}

class ReaderStateContentError extends ReaderState {
  final String message;

  ReaderStateContentError({this.message});
  @override
  List<Object> get props => [message];
}

class ReaderStateContentSuccess extends ReaderState {
  final ParserSiteResponse item;

  ReaderStateContentSuccess({this.item});
  @override
  List<Object> get props => [item];
}

class ReaderStateContentLoading extends ReaderState {
  ReaderStateContentLoading();
  @override
  List<Object> get props => [];
}
