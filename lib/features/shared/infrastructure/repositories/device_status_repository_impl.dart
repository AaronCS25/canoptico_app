import 'package:canoptico_app/features/shared/shared.dart';

class DeviceStatusRepositoryImpl implements DeviceStatusRepository {
  final DeviceStatusDatasource datasource;

  DeviceStatusRepositoryImpl({required this.datasource});

  @override
  Future<BowlFood> getBowlFood() {
    return datasource.getBowlFood();
  }

  @override
  Future<FeederHumidity> getFeederHumidity() {
    return datasource.getFeederHumidity();
  }

  @override
  Future<FeederLevel> getFeederLevel() {
    return datasource.getFeederLevel();
  }

  @override
  Future<FeederTemperature> getFeederTemperature() {
    return datasource.getFeederTemperature();
  }
}
