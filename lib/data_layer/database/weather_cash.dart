import 'package:shared_preferences/shared_preferences.dart';

class WeatherCashe {
  static Future<void> putWeatherDataInCashe({
    required String weatherData,
    required String key,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(key, weatherData);
  }

  static Future<String> catchWeatherDataFromCash({
    required String key,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String weatherCashe = prefs.getString(key) ?? "";

    return weatherCashe;
  }
}
