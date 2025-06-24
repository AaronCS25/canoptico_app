class BowlFoodModel {
  final int id;
  final DateTime timestamp;
  final int value;

  BowlFoodModel({
    required this.value,
    required this.id,
    required this.timestamp,
  });

  factory BowlFoodModel.fromJson(Map<String, dynamic> json) => BowlFoodModel(
    value: json["value"],
    id: json["id"],
    timestamp: DateTime.parse(json["timestamp"]),
  );
}
