import 'package:dio/dio.dart';
import 'package:canoptico_app/config/config.dart';
import 'package:canoptico_app/features/auth/auth.dart';

class RailwayAuthDatasourceImpl implements AuthDatasource {
  final dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  @override
  Future<AuthEntity> checkAuthStatus(String token) async {
    try {
      await dio.get(
        "/sensors/humidity",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final auth = AuthEntity(token: token, tokenType: 'Bearer');
      return auth;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(e.response?.data["detail"] ?? 'Token no valido', 401);
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Tiempo de espera agotado', 503);
      }
      throw Exception("AuthCheck - An unexpected error occurred");
    } catch (e) {
      throw Exception("AuthCheck - An unexpected error occurred");
    }
  }

  @override
  Future<AuthEntity> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/login',
        data: {'username': email, 'password': password},
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      final user = AuthMapper.loginResponseModelToAuth(
        LoginResponseModel.fromJson(response.data),
      );

      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(
          e.response?.data["detail"] ?? 'Credenciales incorrectas',
          401,
        );
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Tiempo de espera agotado', 503);
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<int> register(Map<String, dynamic> userLike) async {
    try {
      final response = await dio.post('/register', data: userLike);
      return response.data["id"];
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw CustomError(e.response?.data["detail"] ?? 'Bad request', 401);
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Tiempo de espera agotado', 503);
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
}
