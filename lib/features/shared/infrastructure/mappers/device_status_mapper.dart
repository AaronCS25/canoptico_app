import 'package:canoptico_app/features/shared/shared.dart';

class DeviceStatusMapper {
  static BowlFood bowlFoodModelToEntity(BowlFoodModel model) => BowlFood(
    amount: double.parse(model.value.toString()),
    timestamp: model.timestamp,
  );

  static FeederHumidity feederHumidityModelToEntity(
    FeederHumidityModel model,
  ) => FeederHumidity(
    humidity: double.parse(model.value.toString()),
    timestamp: model.timestamp,
  );

  static FeederLevel feederLevelModelToEntity(FeederLevelModel model) =>
      FeederLevel(
        amount: double.parse(model.value.toString()),
        timestamp: model.timestamp,
      );

  static FeederTemperature feederTemperatureModelToEntity(
    FeederTemperatureModel model,
  ) => FeederTemperature(
    temperature: double.parse(model.value.toString()),
    timestamp: model.timestamp,
  );
}
