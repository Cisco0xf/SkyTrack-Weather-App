

class WeatherWindData  {
  final double speed;
  final int degree;
  WeatherWindData({
    required this.speed,
    required this.degree,
  });
  factory WeatherWindData.fromJson({required Map<String, dynamic> json}) {
    return WeatherWindData(
      speed: (json["speed"] is int) ? json["speed"].toDouble() : json["speed"],
      degree: json["deg"],
    );
  }
}
