class ScheduleModel {
  final int amount;
  final int hour;
  final String timezone;
  final bool conditional;
  final int conditionalAmount;
  final DateTime createdAt;
  final int id;
  final String serverTime;
  final int minute;
  final bool active;
  final int userId;

  ScheduleModel({
    required this.amount,
    required this.hour,
    required this.timezone,
    required this.conditional,
    required this.conditionalAmount,
    required this.createdAt,
    required this.id,
    required this.serverTime,
    required this.minute,
    required this.active,
    required this.userId,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
    amount: json["amount"],
    hour: json["hour"],
    timezone: json["timezone"],
    conditional: json["conditional"],
    conditionalAmount: json["conditional_amount"],
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
    serverTime: json["server_time"],
    minute: json["minute"],
    active: json["active"],
    userId: json["user_id"],
  );
}
