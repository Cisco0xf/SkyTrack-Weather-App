import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/common/app_dimension.dart';
import 'package:weatherapp/common/celsius_convertor.dart';
import 'package:weatherapp/common/commons.dart';
import 'package:weatherapp/common/date_foramt.dart';
import 'package:weatherapp/common/get_weather_state_image.dart';
import 'package:weatherapp/common/get_wind_direction.dart';
import 'package:weatherapp/common/glass_layer.dart';
import 'package:weatherapp/common/is_day_or_night.dart';
import 'package:weatherapp/common/time_format.dart';
import 'package:weatherapp/constants/app_colors.dart';
import 'package:weatherapp/constants/gaps.dart';
import 'package:weatherapp/data_layer/models/forcecase_models/next_forcecase_data/next_forcecase_main_data.dart';
import 'package:weatherapp/statemanagement_layer/fetch_weather_data/fetch_weather_data.dart';
import 'package:weatherapp/statemanagement_layer/get_each_day_data/each_day_data_provider.dart';
import 'package:weatherapp/statemanagement_layer/settings_state/change_theme_provider.dart';
import 'package:weatherapp/statemanagement_layer/settings_state/speed_convertor_provider.dart';
import 'package:weatherapp/statemanagement_layer/settings_state/temp_convertor_provider.dart';

class ForcecaseDetailsScreen extends StatefulWidget {
  const ForcecaseDetailsScreen({
    super.key,
    required this.dayTitle,
    required this.forcecaseDailyData,
  });
  final String dayTitle;
  final List<NextForcecaseData> forcecaseDailyData;

  @override
  State<ForcecaseDetailsScreen> createState() => _ForcecaseDetailsScreenState();
}

class _ForcecaseDetailsScreenState extends State<ForcecaseDetailsScreen>
    with TickerProviderStateMixin {
  late final AnimationController _bgAnimatedController;
  late final Animation<Alignment> _topAlignment;
  late final Animation<Alignment> _bottomAlignment;

  @override
  void initState() {
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

    super.initState();
  }

  @override
  void dispose() {
    _bgAnimatedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChangeThemeProvider>(builder: (context, palette, _) {
      return Consumer<EachDayDataProvider>(
        builder: (context, dailyData, _) {
          return Scaffold(
            body: AnimatedBuilder(
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
                    child: Column(
                      children: <Widget>[
                        const Gaps(hRatio: 0.05),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                borderRadius: borderRadius(10.0),
                                color: SwitchColors.mainColor,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                ),
                              ),
                            ),
                            const Gaps(wRatio: 0.02),
                            Text(
                              "${widget.dayTitle} Forcecase",
                              style: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: widget.forcecaseDailyData.length,
                            padding: EdgeInsets.only(
                              top: context.screenHeight * 0.02,
                            ),
                            itemBuilder: (context, index) {
                              NextForcecaseData forcecaseData =
                                  widget.forcecaseDailyData[index];
                              return Container(
                                padding: const EdgeInsets.all(10.0),
                                margin: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  borderRadius: borderRadius(15.0),
                                  color: SwitchColors.mainColor,
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        borderRadius: borderRadius(15.0),
                                        color: Colors.black26.withOpacity(0.4),
                                      ),
                                      child: Text(
                                        forcecaseData.dataDate.formateTimeTemps
                                            .formatTime,
                                        style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Consumer<FetchWeatherProvider>(
                                        builder: (context, accessData, _) {
                                      return SizedBox(
                                        width: context.screenWidth * .3,
                                        height: context.screenHeight * .09,
                                        child: SvgPicture.asset(
                                          weatherStateImage(
                                            code:
                                                forcecaseData.weatherData[0].id,
                                            isDay: isDay(
                                              sunrise: accessData
                                                  .weatherData!.sysData.sunrise,
                                              sunset: accessData
                                                  .weatherData!.sysData.sunset,
                                              isCustom: true,
                                              customHour:
                                                  forcecaseData.dataDate,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                    Text(
                                      "${forcecaseData.weatherData[0].main}(${forcecaseData.weatherData[0].description})",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${forcecaseData.mainData.tempreture.celsiusConvertor.tempConvertor} $currentTempUnite",
                                      style: const TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        ForcecaseDailyWidget(
                                          imagePath:
                                              "assets/images/svg_images/weather_info/wind_degree.svg",
                                          forcecaseData: windDirection(
                                            degree:
                                                forcecaseData.windData.degree,
                                          ),
                                          forcecaseItem: "Wind Direction",
                                        ),
                                        ForcecaseDailyWidget(
                                          imagePath:
                                              "assets/images/svg_images/weather_info/visibility.svg",
                                          forcecaseData:
                                              "${forcecaseData.visibility} m",
                                          forcecaseItem: "Visibility",
                                        ),
                                        ForcecaseDailyWidget(
                                          imagePath:
                                              "assets/images/svg_images/weather_info/wind_speed.svg",
                                          forcecaseData:
                                              "${forcecaseData.windData.speed.speedConvertor} $speedUnite",
                                          forcecaseItem: "Wind Speed",
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        ForcecaseDailyWidget(
                                          imagePath:
                                              "assets/images/svg_images/weather_info/humidity.svg",
                                          forcecaseData:
                                              "${forcecaseData.mainData.humidity} %",
                                          forcecaseItem: "Humidity",
                                        ),
                                        ForcecaseDailyWidget(
                                          imagePath:
                                              "assets/images/svg_images/weather_info/pressure.svg",
                                          forcecaseData:
                                              "${forcecaseData.mainData.pressure} hPa",
                                          forcecaseItem: "Pessure",
                                        ),
                                        ForcecaseDailyWidget(
                                          imagePath:
                                              "assets/images/svg_images/weather_info/clouds.svg",
                                          forcecaseData:
                                              "${forcecaseData.cloudsData.cloudsAll} %",
                                          forcecaseItem: "Clouds",
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          );
        },
      );
    });
  }
}

class ForcecaseDailyWidget extends StatelessWidget {
  const ForcecaseDailyWidget({
    super.key,
    required this.imagePath,
    required this.forcecaseData,
    required this.forcecaseItem,
  });

  final String imagePath;
  final String forcecaseData;
  final String forcecaseItem;

  @override
  Widget build(BuildContext context) {
    return Glassmorphisim(
      radius: 15.0,
      child: Container(
        padding: const EdgeInsets.all(5.0),
        margin: const EdgeInsets.all(5.0),
        width: context.screenWidth * .25,
        decoration: BoxDecoration(
          borderRadius: borderRadius(15.0),
          color: Colors.black26.withOpacity(0.4),
          border: Border.all(color: SwitchColors.borderColor),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: context.screenWidth * .15,
              height: context.screenHeight * .04,
              child: SvgPicture.asset(imagePath),
            ),
            const Gaps(hRatio: 0.01),
            Text(forcecaseData),
            const Gaps(hRatio: 0.01),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(forcecaseItem),
            ),
          ],
        ),
      ),
    );
  }
}
