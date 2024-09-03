import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:survey_app/modules/login/data/use_case/uc_login..dart';
import 'package:survey_app/modules/login/data/use_case/uc_register.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.loginUseCase, required this.registerUseCase})
      : super(const LoginState()) {
    on<RegisterSendForm>(_sendRegister);
    on<LoginSendForm>(_sendLogin);
  }

  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;

  void _sendRegister(RegisterSendForm event, Emitter<LoginState> emit) async {
    emit(state.copyWith(
      loginStatus: LoginStatus.loading,
    ));

    bool? isFormValid = event.registerFormKey?.currentState?.saveAndValidate();

    if (isFormValid != null && !isFormValid) {
      emit(state.copyWith(
        loginStatus: LoginStatus.initial,
      ));
      return;
    }

    Map<String, dynamic>? formValues =
        event.registerFormKey?.currentState?.value;

    try {
      await registerUseCase.call(
          params: RegisterUseCaseParams(body: formValues!));
      emit(state.copyWith(
          loginStatus: LoginStatus.registered,
          message: 'Usuario registrado Exitosamente'));
    } catch (e) {
      log("LOGIN BLOC REGISTER: $e");
      emit(state.copyWith(
        loginStatus: LoginStatus.error,
        errorText: "Error al registrar: ${e.toString()}",
      ));
    }
  }

  void _sendLogin(LoginSendForm event, Emitter emit) async {
    emit(state.copyWith(
      loginStatus: LoginStatus.loading,
    ));

    bool? isFormValid = event.loginFormKey?.currentState?.saveAndValidate();

    if (isFormValid != null && !isFormValid) {
      emit(state.copyWith(
        loginStatus: LoginStatus.initial,
      ));
      return;
    }

    Map<String, dynamic>? formValues = event.loginFormKey?.currentState?.value;

    try {
      dynamic response = await loginUseCase.call(
          params: LoginUseCaseParams(body: formValues!));
      log(response.toString());
      emit(state.copyWith(
          loginStatus: LoginStatus.success,
          message: 'Usuario logueado Exitosamente'));
    } catch (e) {
      log("LOGIN BLOC LOGUIN: $e");
      emit(state.copyWith(
        loginStatus: LoginStatus.error,
        errorText: "Error al loguear: ${e.toString()}",
      ));
    }
    log('_sendLogin');
    log(formValues.toString());
  }
}
