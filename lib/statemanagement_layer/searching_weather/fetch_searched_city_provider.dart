import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:weatherapp/common/my_logger.dart';
import 'package:weatherapp/constants/api_constants.dart';
import 'package:weatherapp/data_layer/models/weather_models/weather_main_data_model.dart';

class SearchingCityWeatherDataProvider with ChangeNotifier {
  Future<WeatherDataModel> fetchSearchedCityWeatherData({
    required String cityName,
  }) async {
    try {
      String apiUrl = ApiConstants.weatherDomain;
      String apiKey = ApiConstants.apikey;

      final String baseURL =
          "$apiUrl?q=$cityName&units=metric&lang=en&appid=$apiKey";

      final Uri uri = Uri.parse(baseURL);

      final apiRequest = await http.get(uri);

      log("Status Code : ${apiRequest.statusCode}");

      if (apiRequest.statusCode == 200) {
        final String requestBody = apiRequest.body;

        final Map<String, dynamic> jsonMap = jsonDecode(requestBody);

        return WeatherDataModel.fromJson(json: jsonMap);
      } else {
        log("Something WeatherDataModel | Status Code :${apiRequest.statusCode}");
        throw Exception();
      }
    } on SocketException {
      log("Check internet connection...");
      throw Exception("Internet error");
    } catch (error) {
      Log.log("Error seatch city weather => $error");
      throw Exception();
    }
  }
}
