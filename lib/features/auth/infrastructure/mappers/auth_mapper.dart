import 'package:canoptico_app/features/auth/auth.dart';

class AuthMapper {
  static AuthEntity loginResponseModelToAuth(LoginResponseModel model) =>
      AuthEntity(token: model.accessToken, tokenType: model.tokenType);
}
