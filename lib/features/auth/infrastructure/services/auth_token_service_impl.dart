import 'dart:convert';

import 'package:canoptico_app/features/auth/auth.dart';
import 'package:canoptico_app/features/shared/shared.dart';

class AuthTokenServiceImpl implements AuthTokenService {
  final DictStorageService _storageService;

  AuthEntity? _inMemoryAuth;

  AuthTokenServiceImpl(this._storageService);

  @override
  Future<void> init() async {
    // Intenta cargar la sesión desde el disco una sola vez al arrancar la app.
    final authJson = await _storageService.get<String>('auth_entity');
    if (authJson != null) {
      final authMap = jsonDecode(authJson) as Map<String, dynamic>;
      _inMemoryAuth = AuthEntity(
        token: authMap['token'],
        tokenType: authMap['tokenType'],
      );
    }
  }

  @override
  Future<AuthEntity?> getAuth() async {
    // Devuelve la entidad desde la memoria. Es casi instantáneo.
    return _inMemoryAuth;
  }

  @override
  Future<void> saveAuth(AuthEntity auth) async {
    // Actualiza la caché en memoria
    _inMemoryAuth = auth;

    // Persiste en el disco en segundo plano
    final authMap = {'token': auth.token, 'tokenType': auth.tokenType};
    await _storageService.save<String>('auth_entity', jsonEncode(authMap));
  }

  @override
  Future<void> deleteAuth() async {
    // Limpia la caché y el disco
    _inMemoryAuth = null;
    await _storageService.delete('auth_entity');
  }
}
