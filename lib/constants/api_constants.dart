import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static final String apikey = dotenv.env["WEATHER_API_KEY"] ?? "UNVALIDE_KEY";

  static const String weatherDomain =
      "https://api.openweathermap.org/data/2.5/weather";

  static const String forcecaseDomain =
      "https://api.openweathermap.org/data/2.5/forecast";
}
