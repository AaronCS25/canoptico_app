import 'package:dio/dio.dart';
import 'package:canoptico_app/features/shared/shared.dart';

class RailwayDeviceStatusDatasourceImpl implements DeviceStatusDatasource {
  late Dio dio;

  RailwayDeviceStatusDatasourceImpl({required this.dio});

  @override
  Future<BowlFood> getBowlFood() async {
    try {
      final response = await dio.get("/sensors/bowl_level");

      if (response.data == null) {
        throw Exception("GetBowl - No data received from the server");
      }

      return DeviceStatusMapper.bowlFoodModelToEntity(
        BowlFoodModel.fromJson(response.data),
      );
    } catch (e) {
      throw Exception("GetBowl - Error fetching data: $e");
    }
  }

  @override
  Future<FeederHumidity> getFeederHumidity() async {
    try {
      final response = await dio.get("/sensors/humidty");

      if (response.data == null) {
        throw Exception("GetFeederHumidity - No data received from the server");
      }

      return DeviceStatusMapper.feederHumidityModelToEntity(
        FeederHumidityModel.fromJson(response.data),
      );
    } catch (e) {
      throw Exception("GetFeederHumidity - Error fetching data: $e");
    }
  }

  @override
  Future<FeederLevel> getFeederLevel() async {
    try {
      final response = await dio.get("/sensors/food_level");

      if (response.data == null) {
        throw Exception("GetFeederLevel - No data received from the server");
      }

      return DeviceStatusMapper.feederLevelModelToEntity(
        FeederLevelModel.fromJson(response.data),
      );
    } catch (e) {
      throw Exception("GetFeederLevel - Error fetching data: $e");
    }
  }

  @override
  Future<FeederTemperature> getFeederTemperature() async {
    try {
      final response = await dio.get("/sensors/temperature");

      if (response.data == null) {
        throw Exception(
          "GetFeederTemperature - No data received from the server",
        );
      }

      return DeviceStatusMapper.feederTemperatureModelToEntity(
        FeederTemperatureModel.fromJson(response.data),
      );
    } catch (e) {
      throw Exception("GetFeederTemperature - Error fetching data: $e");
    }
  }
}
