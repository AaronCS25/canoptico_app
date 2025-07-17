import 'package:canoptico_app/features/schedule/schedule.dart';

class ScheduleMapper {
  static ScheduleEntity scheduleModelToEntity(ScheduleModel model) {
    final now = DateTime.now();

    final scheduleDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      model.hour,
      model.minute,
    );

    return ScheduleEntity(
      id: model.id.toString(),
      scheduleTime: scheduleDateTime,
      amount: model.amount.toDouble(),
      isActive: model.active,
      isConditional: model.conditional,
      conditionValue: model.conditionalAmount.toDouble(),
    );
  }
}
