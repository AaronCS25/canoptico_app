import 'package:canoptico_app/features/shared/shared.dart';

abstract class DeviceStatusDatasource {
  Future<BowlFood> getBowlFood();
  Future<FeederHumidity> getFeederHumidity();
  Future<FeederLevel> getFeederLevel();
  Future<FeederTemperature> getFeederTemperature();
}
