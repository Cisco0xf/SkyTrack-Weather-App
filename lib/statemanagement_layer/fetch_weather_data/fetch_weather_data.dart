import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/common/my_logger.dart';
import 'package:weatherapp/common/navigator_key.dart';
import 'package:weatherapp/common/show_notification.dart';
import 'package:weatherapp/constants/api_constants.dart';
import 'package:weatherapp/constants/texts.dart';
import 'package:weatherapp/data_layer/database/weather_cash.dart';
import 'package:weatherapp/data_layer/models/forcecase_models/next_forcecase_data_model.dart';
import 'package:weatherapp/data_layer/models/weather_models/weather_main_data_model.dart';
import 'package:weatherapp/statemanagement_layer/fetch_weather_data/weather_location.dart';

import 'package:http/http.dart' as http;
import 'package:weatherapp/statemanagement_layer/settings_state/save_last_settings/prefs_keys.dart';

class FetchWeatherProvider extends ChangeNotifier {
  final BuildContext context = navigationKey.currentContext as BuildContext;

  // Location Of the user for Endpoint Query

  WeatherLocation get _userLocation => Provider.of<WeatherLocation>(
        context,
        listen: false,
      );

  // Catch Init Weather Data

  WeatherDataModel? weatherData;

  Future<void> catchWeatherData() async {
    log("Start fetching weather data with long-lat....");

    final UserLocation? targetLocation = _userLocation.userLocation;

    if (targetLocation == null) {
      Log.log("Can notcatch userLocation...");
      await fetchWeatherDataFromCashe();
      return;
    }

    try {
      const String base = ApiConstants.weatherDomain;

      final String appId = ApiConstants.apikey;

      final String targetUrl =
          "$base?lat=${targetLocation.latitude}&lon=${targetLocation.longtude}&appid=$appId";

      Log.log("Target Url => $targetUrl");

      final Uri uri = Uri.parse(targetUrl);

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        await WeatherCashe.putWeatherDataInCashe(
          weatherData: response.body,
          key: PrefsKeys.WEATHER_KEY,
        ).whenComplete(
          () {
            Log.log(
              "Data has been added to Database => ${response.body}",
            );
          },
        );

        final WeatherDataModel target = WeatherDataModel.fromJson(
          json: jsonData,
        );

        // weatherData = target;
        Log.log("Data has been recieved Successfully !!");

        weatherData = target;
      } else {
        Log.log(
          "Cannot catch the user data | Status Code => ${response.statusCode}",
          color: LColor.white,
        );
        showToastification(title: someIssue);
        await fetchWeatherDataFromCashe();
      }
    } on SocketException {
      log("Internet Error...");
      await fetchWeatherDataFromCashe();
      showToastification(title: internetIssue);
    } catch (error) {
      Log.log("Error While Catching WeatherData => $error", color: LColor.red);
      showToastification(title: someIssue);
      await fetchWeatherDataFromCashe();
    }
  }

  Future<void> fetchWeatherDataFromCashe() async {
    final String weatherCashe = await WeatherCashe.catchWeatherDataFromCash(
      key: PrefsKeys.WEATHER_KEY,
    );

    Log.log("Weather Data from Cashe => $weatherCashe");

    if (weatherCashe.isEmpty) {
      Log.log("Empty Data from Cashe...");
      return;
    }

    try {
      final Map<String, dynamic> jsonMap = json.decode(weatherCashe);

      weatherData = WeatherDataModel.fromJson(json: jsonMap);

      Log.log("Weather data has been loaded from Cashe Successfully...");
    } catch (error) {
      Log.log(
        "Error Loading Cash Weather Data => $error",
        color: LColor.red,
      );
    }
  }

  // Catch Forecast Weather Data

  WeatherForcecaseDataModel? forecast;

  Future<void> catchForescastWeatherData() async {
    try {
      final UserLocation? targetLocation = _userLocation.userLocation;

      if (targetLocation == null) {
        Log.log("Redebug the Location ...");
        await fetchForecastDataFromCashe();
        return;
      }

      final String appId = ApiConstants.apikey;
      const String domain = ApiConstants.forcecaseDomain;

      final String targetUrl =
          "$domain?lat=${targetLocation.latitude}&lon=${targetLocation.longtude}&appid=$appId";

      final Uri url = Uri.parse(targetUrl);

      final reponse = await http.get(url);
      if (reponse.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(reponse.body);

        await WeatherCashe.putWeatherDataInCashe(
          weatherData: reponse.body,
          key: PrefsKeys.FORECAST_KSY,
        ).whenComplete(
          () {
            Log.log(
                "Forecst Data has been added to database => ${reponse.body}");
          },
        );

        final WeatherForcecaseDataModel targetData =
            WeatherForcecaseDataModel.fromJson(json: jsonData);

        //forcaseData = targetData;

        Log.log("Forecast data has been retrives successfully !!");

        forecast = targetData;
      } else {
        Log.log("Issue Happend | Forcast | StatusCode => ${reponse.statusCode}",
            color: LColor.red);

        showToastification(title: someIssue);

        await fetchForecastDataFromCashe();
      }
    } on SocketException {
      Log.log("Internet Error ..", color: LColor.red);

      showToastification(title: internetIssue);

      await fetchForecastDataFromCashe();
    } catch (error) {
      Log.log("Forecast Error => $error", color: LColor.red);

      showToastification(title: someIssue);

      await fetchForecastDataFromCashe();
    }
  }

  Future<void> fetchForecastDataFromCashe() async {
    final String forecastCash = await WeatherCashe.catchWeatherDataFromCash(
      key: PrefsKeys.FORECAST_KSY,
    );

    if (forecastCash.isEmpty) {
      Log.log("Empty Data from Forcecast Cash...", color: LColor.red);
      return;
    }

    try {
      final Map<String, dynamic> forecastData = json.decode(forecastCash);

      forecast = WeatherForcecaseDataModel.fromJson(json: forecastData);

      Log.log("Forecast Data has been retrived from cashe Successsfully !!");
    } catch (error) {
      Log.log("Error Loading Forecast Data from Cash => $error",
          color: LColor.red);
    }
  }

  // Check for error from null value in both Models

  bool get hasError => weatherData == null || forecast == null;

  // Refresh and update the data

  bool isLoading = false;

  Future<void> updateWeatherData({bool updateUi = true}) async {
    isLoading = true;
    if (updateUi) {
      notifyListeners();
    }

    await _userLocation.getUserLocation();

    await catchWeatherData();
    await catchForescastWeatherData();

    isLoading = false;

    notifyListeners();
  }
}
