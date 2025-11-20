import 'package:weatherapp/data_layer/models/forcecase_models/forcecase_clouds_data/forcecase_clouds_data.dart';
import 'package:weatherapp/data_layer/models/forcecase_models/forcecase_main_data/forcecase_main_data.dart';
import 'package:weatherapp/data_layer/models/forcecase_models/forcecase_weather_data/forcecase_weather_data.dart';
import 'package:weatherapp/data_layer/models/forcecase_models/forcecase_wind_data/forcecase_wind_data.dart';
class NextForcecaseData  /* extends HiveObject */ {
  final int dataDate;
  final int? visibility;
  final String dateText;
  final ForcecaseWindData windData;
  final ForcecaseMainData mainData;
  final ForcecaseCloudsData cloudsData;
  final List<ForcecaseWeatherData> weatherData;

  NextForcecaseData({
    required this.dataDate,
    required this.dateText,
    required this.cloudsData,
    required this.windData,
    required this.mainData,
    this.visibility,
    required this.weatherData,
  });

  factory NextForcecaseData.fromJson({
    required Map<String, dynamic> json,
  }) {
    return NextForcecaseData(
      dataDate: json["dt"] ?? 0,
      dateText: json["dt_txt"] ?? "",
      visibility: json["visibility"] ?? 0,
      windData: ForcecaseWindData.fromJson(json: json["wind"]),
      cloudsData: ForcecaseCloudsData.fromJson(json: json["clouds"]),
      mainData: ForcecaseMainData.fromJson(json: json["main"]),
      weatherData: (json["weather"] as List<dynamic>).map(
        (weather) {
          return ForcecaseWeatherData.fromJson(json: weather);
        },
      ).toList(),
    );
  }
}
