import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/common/app_dimension.dart';
import 'package:weatherapp/constants/gaps.dart';
import 'package:weatherapp/data_layer/models/weather_models/weather_main_data_model.dart';
import 'package:weatherapp/presentation_layer/home_screen/components/sunrise_sunset_widget.dart';
import 'package:weatherapp/presentation_layer/home_screen/components/weather_main_info.dart';
import 'package:weatherapp/presentation_layer/home_screen/components/weather_state_widget.dart';
import 'package:weatherapp/presentation_layer/home_screen/components/weather_wind_info.dart';
import 'package:weatherapp/presentation_layer/searching_screen/searching_details/not_found_city.dart';
import 'package:weatherapp/presentation_layer/searching_screen/searching_details/search_city_title.dart';
import 'package:weatherapp/statemanagement_layer/searching_weather/fetch_searched_city_provider.dart';
import 'package:weatherapp/statemanagement_layer/settings_state/change_theme_provider.dart';

class SearchingCityWeatherDataMainScreen extends StatefulWidget {
  const SearchingCityWeatherDataMainScreen({
    super.key,
    required this.cityName,
    this.isMap = false,
  });
  final String cityName;
  final bool isMap;

  @override
  State<SearchingCityWeatherDataMainScreen> createState() =>
      _SearchingCityWeatherDataMainScreenState();
}

class _SearchingCityWeatherDataMainScreenState
    extends State<SearchingCityWeatherDataMainScreen>
    with TickerProviderStateMixin {
  late final AnimationController _bgAnimatedController;
  late final Animation<Alignment> _topAlignment;
  late final Animation<Alignment> _bottomAlignment;

  void get _animateBG {
    _bgAnimatedController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _topAlignment = TweenSequence<Alignment>(
      <TweenSequenceItem<Alignment>>[
        TweenSequenceItem(
          tween: Tween<Alignment>(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween<Alignment>(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
          ),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween<Alignment>(
            begin: Alignment.bottomRight,
            end: Alignment.bottomLeft,
          ),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween<Alignment>(
            begin: Alignment.bottomLeft,
            end: Alignment.topLeft,
          ),
          weight: 1,
        ),
      ],
    ).animate(_bgAnimatedController);
    _bottomAlignment = TweenSequence<Alignment>(
      <TweenSequenceItem<Alignment>>[
        TweenSequenceItem(
          tween: Tween<Alignment>(
            begin: Alignment.bottomLeft,
            end: Alignment.topLeft,
          ),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween<Alignment>(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween<Alignment>(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
          ),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween<Alignment>(
            begin: Alignment.bottomRight,
            end: Alignment.bottomLeft,
          ),
          weight: 1,
        ),
      ],
    ).animate(_bgAnimatedController);
  }

  late final Future<WeatherDataModel> fetchCityWeatherData;
  late final SearchingCityWeatherDataProvider cityWeatherData;
  @override
  initState() {
    _animateBG;
    cityWeatherData = Provider.of<SearchingCityWeatherDataProvider>(
      context,
      listen: false,
    );

    fetchCityWeatherData = cityWeatherData.fetchSearchedCityWeatherData(
      cityName: widget.cityName,
    );
    super.initState();
  }

  @override
  void dispose() {
    _bgAnimatedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Consumer<ChangeThemeProvider>(
        builder: (context, palette, _) {
          return AnimatedBuilder(
            animation: _bgAnimatedController,
            builder: (context, _) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: palette.colorsPalette,
                    begin: _topAlignment.value,
                    end: _bottomAlignment.value,
                  ),
                ),
                child: FutureBuilder(
                  future: fetchCityWeatherData,
                  builder: (context, snapShot) {
                    if (snapShot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SizedBox(
                          width: context.screenWidth * .6,
                          height: context.screenHeight * .14,
                          child: Lottie.asset(
                            "assets/animations/animations/clouds_laoding.json",
                          ),
                        ),
                      );
                    } else if (snapShot.hasError) {
                      return NotFoundCityWidget(
                        cityName: widget.cityName,
                        isMap: widget.isMap,
                      );
                    } else if (snapShot.hasData) {
                      WeatherDataModel cityWeather =
                          snapShot.data as WeatherDataModel;
                      return Column(
                        children: <Widget>[
                          const Gaps(hRatio: 0.05),
                          CityWeatherTitleWidget(
                            cityName: cityWeather.cityName,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  const Gaps(hRatio: 0.02),
                                  WeatherStateWidget(
                                    main: cityWeather.weatherState[0].main,
                                    description:
                                        cityWeather.weatherState[0].description,
                                    maxTemp: cityWeather.mainData.maxTemp,
                                    minTemp: cityWeather.mainData.minTemp,
                                    tempreture: cityWeather.mainData.tempreture,
                                    code: cityWeather.weatherState[0].id,
                                    sunrise: cityWeather.sysData.sunrise,
                                    sunset: cityWeather.sysData.sunset,
                                    cityDate: cityWeather.date,
                                    isSearching: true,
                                  ),
                                  const Gaps(hRatio: 0.02),
                                  WeatherWindInfoWidget(
                                    speed: cityWeather.wind.speed,
                                    degree: cityWeather.wind.degree,
                                    visibility: cityWeather.visibility as int,
                                  ),
                                  const Gaps(hRatio: 0.02),
                                  WeatherMainInfoWidget(
                                    pressure: cityWeather.mainData.pressure,
                                    cloudsAll: cityWeather.clouds.all,
                                    hamidity: cityWeather.mainData.humidity,
                                  ),
                                  const Gaps(hRatio: 0.02),
                                  SunriseSunsetDataWidget(
                                    sunrise: cityWeather.sysData.sunrise,
                                    sunset: cityWeather.sysData.sunset,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Center(
                        child: Text(
                          "You Fucked Up",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      );
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
