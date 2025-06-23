part of 'signup_form_bloc.dart';

enum FormSubmissionStatus { initial, attempted, inProgress, success, failure }

class SignupFormState extends Equatable {
  final bool isValid;
  final FormSubmissionStatus submissionStatus;
  final UserName userName;
  final Email email;
  final Password password;
  final String? errorMessage;

  const SignupFormState({
    this.isValid = false,
    this.submissionStatus = FormSubmissionStatus.initial,
    this.userName = const UserName.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
    isValid,
    submissionStatus,
    userName,
    email,
    password,
    errorMessage,
  ];

  bool get isSubmitting => submissionStatus == FormSubmissionStatus.inProgress;
  bool get isSubmissionSuccess =>
      submissionStatus == FormSubmissionStatus.success;
  bool get isSubmissionFailure =>
      submissionStatus == FormSubmissionStatus.failure;

  bool get shouldShowErrors => submissionStatus != FormSubmissionStatus.initial;

  SignupFormState copyWith({
    bool? isValid,
    FormSubmissionStatus? submissionStatus,
    UserName? userName,
    Email? email,
    Password? password,
    String? errorMessage,
  }) {
    return SignupFormState(
      isValid: isValid ?? this.isValid,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      errorMessage: errorMessage,
    );
  }
}
