import 'package:canoptico_app/features/schedule/schedule.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleDatasource datasource;

  ScheduleRepositoryImpl(this.datasource);

  @override
  Future<ScheduleEntity> createSchedule(Map<String, dynamic> scheduleData) {
    return datasource.createSchedule(scheduleData);
  }

  @override
  Future<List<ScheduleEntity>> getSchedules() {
    return datasource.getSchedules();
  }

  @override
  Future<ScheduleEntity> updateSchedule(
    String scheduleId,
    Map<String, dynamic> scheduleData,
  ) {
    return datasource.updateSchedule(scheduleId, scheduleData);
  }
}
