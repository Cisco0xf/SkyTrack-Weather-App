
class WeatherStateData {
  final int id;
  final String main;
  final String description;
  final String iconpath;
  WeatherStateData({
    required this.id,
    required this.main,
    required this.description,
    required this.iconpath,
  });

  factory WeatherStateData.fromJson({required Map<String, dynamic> json}) {
    return WeatherStateData(
      id: json["id"],
      main: json["main"],
      description: json["description"],
      iconpath: json["icon"],
    );
  }
}
