part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

final class ChangePageEvent extends HomeEvent {
  const ChangePageEvent({this.page});

  final int? page;

  @override
  List<Object?> get props => [page];
}

final class StartedPageControllerEvent extends HomeEvent {}

final class FinishedPageControllerEvent extends HomeEvent {}