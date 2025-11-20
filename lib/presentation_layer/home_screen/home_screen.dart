import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/constants/gaps.dart';
import 'package:weatherapp/data_layer/models/weather_models/weather_main_data_model.dart';
import 'package:weatherapp/presentation_layer/home_screen/components/hourly_weather_state.dart';
import 'package:weatherapp/presentation_layer/home_screen/components/main_screen_title.dart';
import 'package:weatherapp/presentation_layer/home_screen/components/sunrise_sunset_widget.dart';
import 'package:weatherapp/presentation_layer/home_screen/components/weather_main_info.dart';
import 'package:weatherapp/presentation_layer/home_screen/components/weather_wind_info.dart';
import 'package:weatherapp/presentation_layer/home_screen/components/weather_state_widget.dart';
import 'package:weatherapp/statemanagement_layer/fetch_weather_data/fetch_weather_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    /*  required this.refreshData, */
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /* final Future<void> Function() refreshData; */

  late final FetchWeatherProvider fetchWeather;

  /*  WeatherDataModel? weatherData;
  WeatherForcecaseDataModel? weatherForecast;

  void getData() async {
    List weather = await fetchWeather.weatherData!;

    weatherData = weather[0];
    weatherForecast = weather[1];
  } */

  @override
  void initState() {
    fetchWeather = Provider.of<FetchWeatherProvider>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FetchWeatherProvider>(
      builder: (context, accessData, _) {
        final WeatherDataModel? weatherData = fetchWeather.weatherData;

        String cityName = weatherData!.cityName;
        int visibility = weatherData.visibility as int;
        // Main Data
        double tempreture = weatherData.mainData.tempreture;
        /* feels = weatherData.mainData.feesLike; */
        double maxTemp = weatherData.mainData.maxTemp;
        double minTemp = weatherData.mainData.minTemp;
        int hamidty = weatherData.mainData.humidity;
        int pressure = weatherData.mainData.pressure;
        // Wind data
        int degree = weatherData.wind.degree;
        double speed = weatherData.wind.speed;
        int cloudsAll = weatherData.clouds.all;
        // Weather Data

        List<dynamic> weatherState = weatherData.weatherState;
        int code = weatherState[0].id;

        // Sys Data

        int sysSunset = weatherData.sysData.sunset;
        int sysSunrise = weatherData.sysData.sunrise;
        return RefreshIndicator(
          onRefresh: () async {
            await fetchWeather.updateWeatherData();
          } /* widget.refreshData */,
          child: Column(
            children: <Widget>[
              const Gaps(hRatio: 0.05),
              TitleWidget(
                cityName: cityName,
              ),
              const Gaps(hRatio: 0.02),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      const Gaps(hRatio: 0.02),
                      WeatherStateWidget(
                        tempreture: tempreture,
                        description: weatherState[0].description,
                        main: weatherState[0].main,
                        code: code,
                        maxTemp: maxTemp,
                        minTemp: minTemp,
                        sunrise: sysSunrise,
                        sunset: sysSunset,
                      ),
                      const Gaps(hRatio: 0.02),
                      WeatherWindInfoWidget(
                        speed: speed,
                        visibility: visibility,
                        degree: degree,
                      ),
                      const Gaps(hRatio: 0.01),
                      WeatherMainInfoWidget(
                        pressure: pressure,
                        cloudsAll: cloudsAll,
                        hamidity: hamidty,
                      ),
                      const Gaps(hRatio: 0.02),
                      SunriseSunsetDataWidget(
                        sunrise: sysSunrise,
                        sunset: sysSunset,
                      ),
                      const Gaps(hRatio: 0.02),
                      HourlyWeatherStateWidget(
                        forcecaseData: fetchWeather.forecast!.forcecaseDataList,
                        sunrise: sysSunrise,
                        sunset: sysSunset,
                      ),
                      const Gaps(hRatio: 0.14),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
