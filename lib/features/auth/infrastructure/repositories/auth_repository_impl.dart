import 'package:canoptico_app/features/auth/auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<AuthEntity> checkAuthStatus(String token) {
    return datasource.checkAuthStatus(token);
  }

  @override
  Future<AuthEntity> login(String email, String password) {
    return datasource.login(email, password);
  }

  @override
  Future<int> register(Map<String, dynamic> userLike) {
    return datasource.register(userLike);
  }
}
