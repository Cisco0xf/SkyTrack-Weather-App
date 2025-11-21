import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weatherapp/common/app_dimension.dart';
import 'package:weatherapp/common/celsius_convertor.dart';
import 'package:weatherapp/common/commons.dart';
import 'package:weatherapp/common/date_foramt.dart';
import 'package:weatherapp/common/get_weather_state_image.dart';
import 'package:weatherapp/common/glass_layer.dart';
import 'package:weatherapp/common/is_day_or_night.dart';
import 'package:weatherapp/common/timestamp_format.dart';
import 'package:weatherapp/constants/app_colors.dart';
import 'package:weatherapp/constants/gaps.dart';
import 'package:weatherapp/data_layer/models/forcecase_models/next_forcecase_data/next_forcecase_main_data.dart';
import 'package:weatherapp/statemanagement_layer/settings_state/change_theme_provider.dart';
import 'package:weatherapp/statemanagement_layer/settings_state/temp_convertor_provider.dart';

class HourlyWeatherStateWidget extends StatelessWidget {
  const HourlyWeatherStateWidget({
    super.key,
    required this.forcecaseData,
    required this.sunrise,
    required this.sunset,
  });

  final List<NextForcecaseData> forcecaseData;
  final int sunrise;
  final int sunset;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Hourly Forcecase",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              /* Text(
                currentDate.formatedDate(format: "MMMM, d"),
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ), */
            ],
          ),
        ),
        const Gaps(hRatio: 0.01),
        SizedBox(
          height: context.screenHeight * .25,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: forcecaseData.length,
            itemBuilder: (context, index) {
              NextForcecaseData hourlyForcecase = forcecaseData[index];
              return HourlyInfoWidget(
                isFirst: index == 0,
                hour: hourlyForcecase.dataDate.foramtTimesTampt,
                imagePath: weatherStateImage(
                  code: hourlyForcecase.weatherData[0].id,
                  isDay: isDay(
                    sunrise: sunrise,
                    isCustom: true,
                    customHour: hourlyForcecase.dataDate,
                    sunset: sunset,
                  ),
                ),
                timesTemp: hourlyForcecase.dataDate,
                tempDegree:
                    "${hourlyForcecase.mainData.tempreture.celsiusConvertor.tempConvertor} $currentTempUnite",
              );
            },
          ),
        ),
      ],
    );
  }
}

class HourlyInfoWidget extends StatelessWidget {
  const HourlyInfoWidget({
    super.key,
    required this.hour,
    required this.imagePath,
    required this.tempDegree,
    required this.timesTemp,
    this.isFirst = false,
  });
  final String hour;
  final String imagePath;
  final String tempDegree;
  final int timesTemp;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    final String hourlyDate =
        timesTemp.formateTimeTemps.formatedDate(format: "MMM d");
    return Glassmorphisim(
      radius: 20.0,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: borderRadius(20),
          color: isFirst
              ? context.isLight
                  ? const Color(0xFF9d91ff).withOpacity(0.4)
                  : const Color(0xFF24194f).withOpacity(0.4)
              : SwitchColors.mainColor,
          border: isFirst
              ? Border.all(
                  color: const Color(0xFFF6F5F5),
                  width: 2.0,
                )
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(hourlyDate),
                Text(hour),
              ],
            ),
            SizedBox(
              width: context.screenWidth * .2,
              height: context.screenHeight * .05,
              child: SvgPicture.asset(imagePath),
            ),
            Text(
              tempDegree,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
