import 'package:dio/dio.dart';
import 'package:canoptico_app/features/schedule/schedule.dart';

class RailwayScheduleDatasourceImpl implements ScheduleDatasource {
  late Dio dio;

  RailwayScheduleDatasourceImpl({required this.dio});

  @override
  Future<ScheduleEntity> createSchedule(
    Map<String, dynamic> scheduleData,
  ) async {
    try {
      final response = await dio.post('/schedule/', data: scheduleData);

      final model = ScheduleModel.fromJson(response.data);

      final entity = ScheduleMapper.scheduleModelToEntity(model);
      return entity;
    } on DioException catch (e) {
      throw Exception('Error creating schedule: ${e.response?.data}');
    } catch (e) {
      throw Exception('An unexpected error occurred');
    }
  }

  @override
  Future<List<ScheduleEntity>> getSchedules() async {
    try {
      final response = await dio.get('/schedule/');

      final List<dynamic> responseData = response.data;

      final List<ScheduleEntity> schedules = responseData.map((json) {
        final model = ScheduleModel.fromJson(json);
        return ScheduleMapper.scheduleModelToEntity(model);
      }).toList();

      return schedules;
    } on DioException catch (e) {
      throw Exception('Error getting schedules: ${e.response?.data}');
    } catch (e) {
      throw Exception('An unexpected error occurred');
    }
  }

  @override
  Future<ScheduleEntity> updateSchedule(
    String scheduleId,
    Map<String, dynamic> scheduleData,
  ) async {
    try {
      final response = await dio.put(
        '/schedule/$scheduleId',
        data: scheduleData,
      );

      final model = ScheduleModel.fromJson(response.data);

      final entity = ScheduleMapper.scheduleModelToEntity(model);
      return entity;
    } on DioException catch (e) {
      throw Exception('Error updating schedule: ${e.response?.data}');
    } catch (e) {
      throw Exception('An unexpected error occurred');
    }
  }
}
