

class WeatherCloudsData {
  final int all;
  WeatherCloudsData({
    required this.all,
  });

  factory WeatherCloudsData.fromJson({required Map<String, dynamic> json}) {
    return WeatherCloudsData(
      all: json["all"],
    );
  }
}
