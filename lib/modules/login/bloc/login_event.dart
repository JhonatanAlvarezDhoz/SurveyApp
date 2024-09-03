part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class RegisterSendForm extends LoginEvent {
  const RegisterSendForm({
    this.registerFormKey,
  });

  final GlobalKey<FormBuilderState>? registerFormKey;

  @override
  List<Object?> get props => [registerFormKey];
}

class LoginSendForm extends LoginEvent {
  const LoginSendForm({
    this.loginFormKey,
  });

  final GlobalKey<FormBuilderState>? loginFormKey;

  @override
  List<Object?> get props => [loginFormKey];
}

class LogoutEvent extends LoginEvent {
  const LogoutEvent();

  @override
  List<Object?> get props => [];
}
