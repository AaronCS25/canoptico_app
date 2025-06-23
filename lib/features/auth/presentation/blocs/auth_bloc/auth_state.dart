part of 'auth_bloc.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus status;
  final AuthEntity? auth;
  final String errorMessage;

  const AuthState({
    this.status = AuthStatus.checking,
    this.auth,
    this.errorMessage = '',
  });

  AuthState copyWith({
    AuthStatus? status,
    AuthEntity? auth,
    String? errorMessage,
  }) {
    return AuthState(
      auth: auth,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
