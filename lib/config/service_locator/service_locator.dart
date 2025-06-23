import 'package:get_it/get_it.dart';
import 'package:canoptico_app/features/auth/auth.dart';

class ServiceLocator {
  static final _getIt = GetIt.instance;

  static T get<T extends Object>() => _getIt.get<T>();

  static Future<void> init() async {
    _getIt.registerLazySingleton<AuthRepositoryImpl>(
      () => AuthRepositoryImpl(RailwayAuthDatasourceImpl()),
    );
  }
}
