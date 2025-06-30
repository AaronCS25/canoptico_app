import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:canoptico_app/config/config.dart';
import 'package:canoptico_app/features/auth/auth.dart';
import 'package:canoptico_app/features/shared/shared.dart';
import 'package:canoptico_app/features/dashboard/dashboard.dart';

class ServiceLocator {
  static final _getIt = GetIt.instance;

  static T get<T extends Object>() => _getIt.get<T>();

  static Future<void> init() async {
    _getIt.registerLazySingleton<DictStorageService>(
      () => DictStorageServiceImpl(),
    );

    _getIt.registerSingleton<AuthTokenService>(
      AuthTokenServiceImpl(_getIt.get<DictStorageService>()),
    );

    await _getIt.get<AuthTokenService>().init();

    _getIt.registerLazySingleton<Dio>(() {
      final dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

      dio.interceptors.add(AuthInterceptor(_getIt.get<AuthTokenService>()));

      return dio;
    });

    _getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(RailwayAuthDatasourceImpl()),
    );

    _getIt.registerLazySingleton<DeviceStatusRepository>(
      () => DeviceStatusRepositoryImpl(
        datasource: RailwayDeviceStatusDatasourceImpl(dio: _getIt<Dio>()),
      ),
    );

    _getIt.registerLazySingleton<CameraStreamDatasource>(
      () => RailwayCameraStreamDatasource(),
    );

    _getIt.registerLazySingleton<CameraStreamRepository>(
      () => CameraStreamRepositoryImpl(_getIt.get<CameraStreamDatasource>()),
    );
  }
}
