import 'package:dio/dio.dart';
import 'package:canoptico_app/features/auth/auth.dart';

class AuthInterceptor extends Interceptor {
  final AuthTokenService authTokenService;

  AuthInterceptor(this.authTokenService);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Lee el token de tu servicio de almacenamiento
    final auth = await authTokenService.getAuth();

    // Si no hay token (el usuario no está logueado), simplemente continúa con la petición.
    // La API debería devolver un error 401 que puedes manejar.
    if (auth == null) {
      return super.onRequest(options, handler);
    }

    // Si hay un token, lo añadimos a los headers
    options.headers['Authorization'] = 'Bearer ${auth.token}';

    super.onRequest(options, handler);
  }
}
