class ScheduleEntity {
  final String id;
  final DateTime scheduleTime;
  final double amount;
  final bool isActive;
  final bool isConditional;
  final double conditionValue;

  ScheduleEntity({
    required this.id,
    required this.scheduleTime,
    required this.amount,
    required this.isActive,
    required this.isConditional,
    required this.conditionValue,
  });
}
