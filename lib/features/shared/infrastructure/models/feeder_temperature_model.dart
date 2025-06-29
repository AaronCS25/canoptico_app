class FeederTemperatureModel {
  final int id;
  final DateTime timestamp;
  final double value;

  FeederTemperatureModel({
    required this.timestamp,
    required this.id,
    required this.value,
  });

  factory FeederTemperatureModel.fromJson(Map<String, dynamic> json) =>
      FeederTemperatureModel(
        timestamp: DateTime.parse(json["timestamp"]),
        id: json["id"],
        value: json["value"],
      );
}
