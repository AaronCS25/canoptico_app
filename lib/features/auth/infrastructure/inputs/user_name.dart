import 'package:formz/formz.dart';

enum UserNameError { empty, length, format }

class UserName extends FormzInput<String, UserNameError> {
  // Empieza con letra (mayúscula o minúscula, tildes y ñ admitidas),
  // seguido de letras, números, guiones bajos o guiones medios.
  static final RegExp _userNameRegExp = RegExp(
    r'^[A-Za-zÁÉÍÓÚáéíóúÑñ][A-Za-zÁÉÍÓÚáéíóúÑñ0-9_-]*$',
  );

  static const int minLength = 3;
  static const int maxLength = 15;

  const UserName.pure() : super.pure('');
  const UserName.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    switch (displayError) {
      case UserNameError.empty:
        return 'El nombre de usuario es obligatorio';
      case UserNameError.length:
        return 'Debe tener entre $minLength y $maxLength caracteres';
      case UserNameError.format:
        return 'El nombre solo puede contener letras y números';
      default:
        return null;
    }
  }

  @override
  UserNameError? validator(String value) {
    if (value.trim().isEmpty) {
      return UserNameError.empty;
    }
    if (value.length < minLength || value.length > maxLength) {
      return UserNameError.length;
    }
    if (!_userNameRegExp.hasMatch(value)) {
      return UserNameError.format;
    }
    return null;
  }
}
