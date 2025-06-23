import 'package:canoptico_app/features/auth/auth.dart';

abstract class AuthRepository {
  Future<AuthEntity> login(String email, String password);
  Future<int> register(Map<String, dynamic> userLike);
  Future<AuthEntity> checkAuthStatus(String token);
}
