part of 'login_form_bloc.dart';

sealed class LoginFormEvent {
  const LoginFormEvent();
}

class LoginFormEmailChanged extends LoginFormEvent {
  final String value;

  const LoginFormEmailChanged(this.value);
}

class LoginFormPasswordChanged extends LoginFormEvent {
  final String value;

  const LoginFormPasswordChanged(this.value);
}

class LoginFormSubmitted extends LoginFormEvent {
  const LoginFormSubmitted();
}
