import 'package:weatherapp/data_layer/models/weather_models/long_lat_data/long_lat_data.dart';
import 'package:weatherapp/data_layer/models/weather_models/main_weater_data/main_weather_data.dart';
import 'package:weatherapp/data_layer/models/weather_models/sys_data/sys_data.dart';
import 'package:weatherapp/data_layer/models/weather_models/weather_clouds_data/weather_clouds_data.dart';
import 'package:weatherapp/data_layer/models/weather_models/weather_state_data/weather_state_data.dart';
import 'package:weatherapp/data_layer/models/weather_models/weather_wind_data/weather_wind_data.dart';


class WeatherDataModel  {
  final String cityName;
  final int? visibility;
  final LonLatData lonlat;
  final MainWeatherData mainData;
  final WeatherWindData wind;
  final int date;
  final WeatherCloudsData clouds;
  final List<WeatherStateData> weatherState;
  final SysDataModel sysData;

  WeatherDataModel({
    required this.cityName,
    this.visibility,
    required this.lonlat,
    required this.date,
    required this.mainData,
    required this.wind,
    required this.clouds,
    required this.weatherState,
    required this.sysData,
  });

  factory WeatherDataModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return WeatherDataModel(
      cityName: json["name"],
      visibility: json["visibility"] ?? 0,
      date: json["dt"],
      lonlat: LonLatData.fromJson(json: json["coord"]),
      mainData: MainWeatherData.fromJson(json: json["main"]),
      wind: WeatherWindData.fromJson(json: json["wind"]),
      clouds: WeatherCloudsData.fromJson(json: json["clouds"]),
      sysData: SysDataModel.fromJson(json: json["sys"]),
      weatherState: (json["weather"] as List<dynamic>).map(
        (weather) {
          return WeatherStateData.fromJson(json: weather);
        },
      ).toList(),
    );
  }
}
