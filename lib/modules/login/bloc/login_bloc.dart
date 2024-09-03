import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:survey_app/modules/common/constants/storage.dart';
import 'package:survey_app/modules/login/data/models/m_user_session.dart';
import 'package:survey_app/modules/login/data/use_case/uc_login..dart';
import 'package:survey_app/modules/login/data/use_case/uc_register.dart';
import 'package:survey_app/utils/secure_storage.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.loginUseCase, required this.registerUseCase})
      : super(const LoginState()) {
    on<RegisterSendForm>(_sendRegister);
    on<LoginSendForm>(_sendLogin);
    on<LogoutEvent>(_logoutSession);
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
      UserSession response = await loginUseCase.call(
          params: LoginUseCaseParams(body: formValues!));

      emit(state.copyWith(
          loginStatus: LoginStatus.success,
          message: 'Usuario logueado Exitosamente',
          session: response));

      SecureStorage()
          .writeSecureData(Storage.accessToken, response.accessToken);
    } catch (e) {
      log("LOGIN BLOC LOGUIN: $e");
      emit(state.copyWith(
        loginStatus: LoginStatus.error,
        errorText: "Error al loguear: ${e.toString()}",
      ));
    }
  }

  void _logoutSession(LogoutEvent event, Emitter emit) async {
    emit(state.copyWith(
      loginStatus: LoginStatus.loading,
    ));

    await SecureStorage().deleteSecureData(Storage.accessToken);

    emit(state.copyWith(
      loginStatus: LoginStatus.initial,
    ));
  }
}
