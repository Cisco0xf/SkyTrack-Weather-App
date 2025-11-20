class ForcecaseWeatherData  {
  final int id;
  final String main;
  final String description;
  final String icon;
  ForcecaseWeatherData({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory ForcecaseWeatherData.fromJson({
    required Map<String, dynamic> json,
  }) {
    return ForcecaseWeatherData(
      id: json["id"],
      main: json["main"],
      description: json["description"],
      icon: json["icon"],
    );
  }
}
