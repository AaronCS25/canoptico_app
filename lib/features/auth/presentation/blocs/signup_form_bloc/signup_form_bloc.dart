import 'package:formz/formz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:canoptico_app/features/auth/auth.dart';

part 'signup_form_event.dart';
part 'signup_form_state.dart';

class SignupFormBloc extends Bloc<SignupFormEvent, SignupFormState> {
  final Future<int> Function(Map<String, dynamic> userLike) signupCallback;

  SignupFormBloc({required this.signupCallback})
    : super(const SignupFormState()) {
    on<SignupFormNameChanged>(_onNameChanged);
    on<SignupFormEmailChanged>(_onEmailChanged);
    on<SignupFormPasswordChanged>(_onPasswordChanged);
    on<SignupFormSubmitted>(_onFormSubmitted);
  }

  void _onNameChanged(
    SignupFormNameChanged event,
    Emitter<SignupFormState> emit,
  ) {
    final newName = UserName.dirty(event.value);
    emit(
      state.copyWith(
        userName: newName,
        isValid: Formz.validate([newName, state.email, state.password]),
      ),
    );
  }

  void _onEmailChanged(
    SignupFormEmailChanged event,
    Emitter<SignupFormState> emit,
  ) {
    final newEmail = Email.dirty(event.value);
    emit(
      state.copyWith(
        email: newEmail,
        isValid: Formz.validate([newEmail, state.userName, state.password]),
      ),
    );
  }

  void _onPasswordChanged(
    SignupFormPasswordChanged event,
    Emitter<SignupFormState> emit,
  ) {
    final newPassword = Password.dirty(event.value);
    emit(
      state.copyWith(
        password: newPassword,
        isValid: Formz.validate([state.email, state.userName, newPassword]),
      ),
    );
  }

  ({UserName name, Email email, Password password, bool isValid})
  _validateInputs() {
    final newName = UserName.dirty(state.userName.value);
    final newEmail = Email.dirty(state.email.value);
    final newPassword = Password.dirty(state.password.value);
    final isValid = Formz.validate([newName, newEmail, newPassword]);

    return (
      name: newName,
      email: newEmail,
      password: newPassword,
      isValid: isValid,
    );
  }

  Future<void> _onFormSubmitted(
    SignupFormSubmitted event,
    Emitter<SignupFormState> emit,
  ) async {
    final validationResult = _validateInputs();
    emit(
      state.copyWith(
        userName: validationResult.name,
        email: validationResult.email,
        password: validationResult.password,
        isValid: validationResult.isValid,
        submissionStatus: FormSubmissionStatus.attempted,
      ),
    );

    if (state.isSubmitting || !validationResult.isValid) return;
    emit(
      state.copyWith(
        isValid: true,
        submissionStatus: FormSubmissionStatus.inProgress,
      ),
    );

    final userLike = {
      "email": state.email.value,
      "password": state.password.value,
      "username": state.userName.value,
    };

    try {
      await signupCallback(userLike);
      emit(state.copyWith(submissionStatus: FormSubmissionStatus.success));
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          submissionStatus: FormSubmissionStatus.failure,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          submissionStatus: FormSubmissionStatus.failure,
          errorMessage: "Signup failed due to an unexpected error.",
        ),
      );
    }
  }
}
