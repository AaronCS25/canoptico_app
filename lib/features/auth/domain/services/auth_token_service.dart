import 'package:canoptico_app/features/auth/auth.dart';

abstract class AuthTokenService {
  Future<void> saveAuth(AuthEntity auth);
  Future<AuthEntity?> getAuth();
  Future<void> deleteAuth();
  Future<void> init();
}
