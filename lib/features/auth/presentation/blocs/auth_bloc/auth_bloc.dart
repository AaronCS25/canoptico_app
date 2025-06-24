import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:canoptico_app/features/auth/auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final AuthTokenService authTokenService;

  AuthBloc({required this.authRepository, required this.authTokenService})
    : super(const AuthState()) {
    on<AuthLogin>(_login);
    on<AuthSignUp>(_signUp);
    on<AuthCheck>(_checkAuth);
    on<AuthSetLoggedUser>(_setLoggedUser);
    on<AuthLogout>(_logout);

    add(const AuthCheck());
  }

  Future<void> _login(AuthLogin event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(status: AuthStatus.checking));

      final auth = await authRepository.login(event.email, event.password);
      add(AuthSetLoggedUser(auth: auth));
    } on CustomError catch (e) {
      add(AuthLogout(e.message));
    } catch (e) {
      add(const AuthLogout("Login - An unexpected error occurred"));
    }
  }

  Future<void> _signUp(AuthSignUp event, Emitter<AuthState> emit) async {
    try {
      await authRepository.register(event.userLike);
    } on CustomError catch (e) {
      add(AuthLogout(e.message));
    } catch (e) {
      add(const AuthLogout("Sign Up - An unexpected error occurred"));
    }
  }

  Future<void> _checkAuth(AuthCheck event, Emitter<AuthState> emit) async {
    final auth = await authTokenService.getAuth();
    if (auth == null) return add(const AuthLogout());

    try {
      final checkedAuth = await authRepository.checkAuthStatus(auth.token);
      add(AuthSetLoggedUser(auth: checkedAuth));
    } catch (e) {
      add(const AuthLogout());
    }
  }

  Future<void> _setLoggedUser(
    AuthSetLoggedUser event,
    Emitter<AuthState> emit,
  ) async {
    await authTokenService.saveAuth(event.auth);
    emit(
      state.copyWith(
        auth: event.auth,
        status: AuthStatus.authenticated,
        errorMessage: "",
      ),
    );
  }

  Future<void> _logout(AuthLogout event, Emitter<AuthState> emit) async {
    await authTokenService.deleteAuth();
    emit(
      state.copyWith(
        auth: null,
        status: AuthStatus.notAuthenticated,
        errorMessage: event.errorMessage,
      ),
    );
  }
}
