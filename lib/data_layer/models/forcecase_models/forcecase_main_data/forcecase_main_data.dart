class ForcecaseMainData   {
  final double tempreture;
  final double maxTemp;
  final double minTemp;
  final int pressure;
  final int humidity;

  ForcecaseMainData({
    required this.tempreture,
    required this.maxTemp,
    required this.minTemp,
    required this.humidity,
    required this.pressure,
  });
  factory ForcecaseMainData.fromJson({
    required Map<String, dynamic> json,
  }) {
    return ForcecaseMainData(
      tempreture:
          (json["temp"] is int) ? json["temp"].toDouble() : json["temp"],
      maxTemp: (json["temp_max"] is int)
          ? json["temp_max"].toDouble()
          : json["temp_max"],
      minTemp: (json["temp_min"] is int)
          ? json["temp_min"].toDouble()
          : json["temp_min"],
      humidity: json["humidity"],
      pressure: json["pressure"],
    );
  }
}
