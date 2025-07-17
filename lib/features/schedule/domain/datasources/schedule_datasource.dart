import 'package:canoptico_app/features/schedule/schedule.dart';

abstract class ScheduleDatasource {
  Future<List<ScheduleEntity>> getSchedules();

  Future<ScheduleEntity> createSchedule(Map<String, dynamic> scheduleData);

  Future<ScheduleEntity> updateSchedule(
    String scheduleId,
    Map<String, dynamic> scheduleData,
  );
}
