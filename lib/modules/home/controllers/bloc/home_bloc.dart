import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<ChangePageEvent>(_onChangePage);
    on<StartedPageControllerEvent>(_onStartedPageControllerEvent);
    on<FinishedPageControllerEvent>(_onFinishedPageControllerEvent);
  }

  void _onChangePage(ChangePageEvent event, Emitter emit) {
    emit(state.copyWith(
      currentPage: event.page,
    ));
  }

  void _onStartedPageControllerEvent(
    StartedPageControllerEvent event,
    Emitter emit,
  ) {
    final PageController controller = PageController();
    controller.addListener(() {});
    emit(state.copyWith(
      pageController: controller,
    ));
  }

  void _onFinishedPageControllerEvent(
    FinishedPageControllerEvent event,
    Emitter emit,
  ) {
    emit(state.copyWith(
      pageController: null,
    ));
  }
}

