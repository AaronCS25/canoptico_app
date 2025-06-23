part of 'signup_form_bloc.dart';

sealed class SignupFormEvent {
  const SignupFormEvent();
}

class SignupFormNameChanged extends SignupFormEvent {
  final String value;

  const SignupFormNameChanged(this.value);
}

class SignupFormEmailChanged extends SignupFormEvent {
  final String value;

  const SignupFormEmailChanged(this.value);
}

class SignupFormPasswordChanged extends SignupFormEvent {
  final String value;

  const SignupFormPasswordChanged(this.value);
}

class SignupFormSubmitted extends SignupFormEvent {
  const SignupFormSubmitted();
}
