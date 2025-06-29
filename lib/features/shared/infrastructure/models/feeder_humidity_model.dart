class FeederHumidityModel {
  final int id;
  final DateTime timestamp;
  final double value;

  FeederHumidityModel({
    required this.id,
    required this.timestamp,
    required this.value,
  });

  factory FeederHumidityModel.fromJson(Map<String, dynamic> json) =>
      FeederHumidityModel(
        id: json["id"],
        timestamp: DateTime.parse(json["timestamp"]),
        value: json["value"],
      );
}
