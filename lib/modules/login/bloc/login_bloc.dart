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
import 'package:jwt_decoder/jwt_decoder.dart';

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
    // se avisa que se va a procesar el login
    emit(state.copyWith(
      loginStatus: LoginStatus.loading,
    ));

    // se valida el formulario
    bool? isFormValid = event.loginFormKey?.currentState?.saveAndValidate();

    // Si no es valido se notifica error
    if (isFormValid != null && !isFormValid) {
      emit(state.copyWith(
        loginStatus: LoginStatus.initial,
      ));
      return;
    }

    Map<String, dynamic>? formValues = event.loginFormKey?.currentState?.value;

    try {
      //Peticion al back y retorna una sesion con solo el token
      UserSession response = await loginUseCase.call(
          params: LoginUseCaseParams(body: formValues!));

      // Se guarda el token en local
      SecureStorage()
          .writeSecureData(Storage.accessToken, response.accessToken);

      // Obtenr user info from token
      String token = response.accessToken;
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

      // se decodifica el token
      Map<String, dynamic> userInfo = decodedToken['sub'];
      String usernameFromToken = userInfo['username'];
      String roleFromToken = userInfo['role'];

      // se actauliza la sesion que solo tenia el token
      UserSession updatedSession = response.copyWith(
        username: usernameFromToken,
        role: roleFromToken,
      );

      // se emite el estado exitoso con el mensaje y la sesion completa
      emit(state.copyWith(
          loginStatus: LoginStatus.success,
          message: 'Usuario logueado Exitosamente',
          session: updatedSession));
    } catch (e) {
      log("LOGIN BLOC LOGUIN: $e");
      emit(state.copyWith(
        loginStatus: LoginStatus.error,
        errorText: "Error al loguearse, revise sus credenciales",
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
