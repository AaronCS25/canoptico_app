class FeederLevelModel {
  final int id;
  final DateTime timestamp;
  final int value;

  FeederLevelModel({
    required this.id,
    required this.value,
    required this.timestamp,
  });

  factory FeederLevelModel.fromJson(Map<String, dynamic> json) =>
      FeederLevelModel(
        id: json["id"],
        value: json["value"],
        timestamp: DateTime.parse(json["timestamp"]),
      );
}
