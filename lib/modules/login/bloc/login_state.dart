part of 'login_bloc.dart';

enum LoginStatus {
  initial,
  success,
  registered,
  loading,
  error,
}

class LoginState extends Equatable {
  const LoginState(
      {this.loginFormKey,
      this.loginStatus = LoginStatus.initial,
      this.errorText = "",
      this.message = "",
      this.session});

  final GlobalKey<FormBuilderState>? loginFormKey;
  final LoginStatus loginStatus;
  final String errorText;
  final String message;
  final UserSession? session;

  LoginState copyWith({
    GlobalKey<FormBuilderState>? loginFormKey,
    LoginStatus? loginStatus,
    String? errorText,
    String? message,
    UserSession? session,
  }) {
    return LoginState(
      loginFormKey: loginFormKey ?? this.loginFormKey,
      loginStatus: loginStatus ?? this.loginStatus,
      errorText: errorText ?? this.errorText,
      message: message ?? this.message,
      session: session ?? this.session,
    );
  }

  @override
  List<Object?> get props =>
      [loginFormKey, loginStatus, errorText, message, session];
}
