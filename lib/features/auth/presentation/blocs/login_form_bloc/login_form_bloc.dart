import 'package:formz/formz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:canoptico_app/features/auth/auth.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  final AuthBloc authBloc;

  LoginFormBloc({required this.authBloc}) : super(const LoginFormState()) {
    on<LoginFormEmailChanged>(_onEmailChanged);
    on<LoginFormPasswordChanged>(_onPasswordChanged);
    on<LoginFormSubmitted>(_onFormSubmitted);
  }

  void _onEmailChanged(
    LoginFormEmailChanged event,
    Emitter<LoginFormState> emit,
  ) {
    final newEmail = Email.dirty(event.value);
    emit(
      state.copyWith(
        email: newEmail,
        isValid: Formz.validate([newEmail, state.password]),
      ),
    );
  }

  void _onPasswordChanged(
    LoginFormPasswordChanged event,
    Emitter<LoginFormState> emit,
  ) {
    final newPassword = Password.dirty(event.value);
    emit(
      state.copyWith(
        password: newPassword,
        isValid: Formz.validate([state.email, newPassword]),
      ),
    );
  }

  ({Email email, Password password, bool isValid}) _validateInputs(
    LoginFormState state,
  ) {
    final newEmail = Email.dirty(state.email.value);
    final newPassword = Password.dirty(state.password.value);
    final isValid = Formz.validate([newEmail, newPassword]);

    return (email: newEmail, password: newPassword, isValid: isValid);
  }

  Future<void> _onFormSubmitted(
    LoginFormSubmitted event,
    Emitter<LoginFormState> emit,
  ) async {
    final validationResult = _validateInputs(state);

    emit(
      state.copyWith(
        email: validationResult.email,
        password: validationResult.password,
        isValid: validationResult.isValid,
        submissionStatus: FormLoginStatus.attempted,
      ),
    );

    if (state.isSubmitting || !validationResult.isValid) return;
    emit(
      state.copyWith(
        isValid: true,
        submissionStatus: FormLoginStatus.inProgress,
      ),
    );

    authBloc.add(
      AuthLogin(email: state.email.value, password: state.password.value),
    );

    emit(state.copyWith(submissionStatus: FormLoginStatus.success));
  }
}
