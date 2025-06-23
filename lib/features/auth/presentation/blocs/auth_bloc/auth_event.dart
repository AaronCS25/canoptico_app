part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();
}

class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  const AuthLogin({required this.email, required this.password});
}

class AuthSignUp extends AuthEvent {
  final Map<String, dynamic> userLike;

  const AuthSignUp({required this.userLike});
}

class AuthCheck extends AuthEvent {
  const AuthCheck();
}

class AuthSetLoggedUser extends AuthEvent {
  final AuthEntity auth;

  const AuthSetLoggedUser({required this.auth});
}

class AuthLogout extends AuthEvent {
  final String? errorMessage;

  const AuthLogout([this.errorMessage]);
}
