

class SysDataModel  {
  final int sunrise;
  final int sunset;

  SysDataModel({
    required this.sunrise,
    required this.sunset,
  });

  factory SysDataModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return SysDataModel(
      sunrise: json["sunrise"] ?? 0,
      sunset: json["sunset"] ?? 0,
    );
  }
}
