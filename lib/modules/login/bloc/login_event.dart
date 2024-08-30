part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class RegisterSendForm extends LoginEvent {
  const RegisterSendForm({
    this.loginFormKey,
  });

  final GlobalKey<FormBuilderState>? loginFormKey;

  @override
  List<Object?> get props => [loginFormKey];
}
