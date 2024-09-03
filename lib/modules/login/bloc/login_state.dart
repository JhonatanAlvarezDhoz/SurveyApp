part of 'login_bloc.dart';

enum LoginStatus {
  initial,
  success,
  loading,
  error,
}

class LoginState extends Equatable {
  const LoginState({
    this.loginFormKey,
    this.loginStatus = LoginStatus.initial,
    this.errorText = "",
    this.message = "",
  });

  final GlobalKey<FormBuilderState>? loginFormKey;
  final LoginStatus loginStatus;
  final String errorText;
  final String message;

  LoginState copyWith({
    GlobalKey<FormBuilderState>? loginFormKey,
    LoginStatus? loginStatus,
    String? errorText,
    String? message,
  }) {
    return LoginState(
      loginFormKey: loginFormKey ?? this.loginFormKey,
      loginStatus: loginStatus ?? this.loginStatus,
      errorText: errorText ?? this.errorText,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [loginFormKey, loginStatus, errorText, message];
}
