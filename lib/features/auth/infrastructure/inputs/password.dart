import 'package:formz/formz.dart';

enum PasswordError {
  empty,
  length,
  formatMayus,
  formatMinus,
  formatNumber,
  notMatch,
}

class Password extends FormzInput<String, PasswordError> {
  static final RegExp passwordRegExp = RegExp(
    r'(?:(?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$',
  );

  final String? confirmPassword;

  const Password.pure({this.confirmPassword}) : super.pure('');

  const Password.dirty(super.value, [this.confirmPassword]) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == PasswordError.empty) return 'El campo es requerido';
    if (displayError == PasswordError.length) return 'Mínimo 8 caracteres';
    if (displayError == PasswordError.formatMayus) {
      return 'Debe de tener Mayúscula';
    }
    if (displayError == PasswordError.formatMinus) {
      return 'Debe de tener Minúscula';
    }
    if (displayError == PasswordError.formatNumber) {
      return 'Debe de tener un número';
    }

    if (displayError == PasswordError.notMatch) {
      return 'Las contraseñas no coinciden';
    }

    return null;
  }

  @override
  PasswordError? validator(String value) {
    if (confirmPassword != null && confirmPassword != value) {
      return PasswordError.notMatch;
    }

    if (value.isEmpty || value.trim().isEmpty) return PasswordError.empty;
    if (value.length < 8) return PasswordError.length;
    if (!passwordRegExp.hasMatch(value)) {
      if (!RegExp(r'[A-Z]').hasMatch(value)) return PasswordError.formatMayus;
      if (!RegExp(r'[a-z]').hasMatch(value)) return PasswordError.formatMinus;
      if (!RegExp(r'[0-9]').hasMatch(value)) return PasswordError.formatNumber;
    }

    return null;
  }
}
