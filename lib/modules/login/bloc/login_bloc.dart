import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoginEvent>((event, emit) {
      on<RegisterSendForm>(_sendRegister);
    });
  }

  void _sendRegister(RegisterSendForm event, Emitter emit) async {
    emit(state.copyWith(
      loginStatus: () => LoginStatus.loading,
    ));

    bool? isFormValid = event.loginFormKey?.currentState?.saveAndValidate();

    if (isFormValid != null && !isFormValid) {
      log('Valid_form_register');
      print(event.loginFormKey?.currentState?.value);
      emit(state.copyWith(
        loginStatus: () => LoginStatus.initial,
      ));
      return;
    }

    Map<String, dynamic>? formValues = event.loginFormKey?.currentState?.value;
  }
}
