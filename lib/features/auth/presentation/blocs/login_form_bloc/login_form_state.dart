part of 'login_form_bloc.dart';

enum FormLoginStatus { initial, attempted, inProgress, success, failure }

class LoginFormState extends Equatable {
  final bool isValid;
  final FormLoginStatus submissionStatus;
  final Email email;
  final Password password;
  final String? errorMessage;

  const LoginFormState({
    this.isValid = false,
    this.submissionStatus = FormLoginStatus.initial,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
    isValid,
    submissionStatus,
    email,
    password,
    errorMessage,
  ];

  bool get isSubmitting => submissionStatus == FormLoginStatus.inProgress;
  bool get isSubmissionSuccess => submissionStatus == FormLoginStatus.success;
  bool get isSubmissionFailure => submissionStatus == FormLoginStatus.failure;

  bool get shouldShowErrors => submissionStatus != FormLoginStatus.initial;

  LoginFormState copyWith({
    bool? isValid,
    FormLoginStatus? submissionStatus,
    Email? email,
    Password? password,
    String? errorMessage,
  }) {
    return LoginFormState(
      isValid: isValid ?? this.isValid,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      email: email ?? this.email,
      password: password ?? this.password,
      errorMessage: errorMessage,
    );
  }
}
