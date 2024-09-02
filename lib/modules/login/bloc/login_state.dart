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
  });

  final GlobalKey<FormBuilderState>? loginFormKey;
  final LoginStatus loginStatus;
  final String errorText;

  LoginState copyWith({
    GlobalKey<FormBuilderState>? loginFormKey,
    LoginStatus Function()? loginStatus,
    String Function()? errorText,
  }) {
    return LoginState(
      loginFormKey: loginFormKey ?? this.loginFormKey,
      loginStatus: loginStatus != null ? loginStatus() : this.loginStatus,
      errorText: errorText != null ? errorText() : this.errorText,
    );
  }

  @override
  List<Object?> get props => [
        loginFormKey,
        loginStatus,
        errorText,
      ];
}
