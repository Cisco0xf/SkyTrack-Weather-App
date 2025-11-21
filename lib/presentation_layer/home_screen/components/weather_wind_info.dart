import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weatherapp/common/app_dimension.dart';
import 'package:weatherapp/common/commons.dart';
import 'package:weatherapp/common/get_wind_direction.dart';
import 'package:weatherapp/common/glass_layer.dart';
import 'package:weatherapp/constants/app_colors.dart';
import 'package:weatherapp/constants/app_textstyle.dart';
import 'package:weatherapp/constants/gaps.dart';
import 'package:weatherapp/statemanagement_layer/settings_state/speed_convertor_provider.dart';

class WeatherWindInfoWidget extends StatelessWidget {
  const WeatherWindInfoWidget({
    super.key,
    required this.speed,
    required this.degree,
    required this.visibility,
  });

  final double speed;
  final int degree;
  final int visibility;

  @override
  Widget build(BuildContext context) {
    return Glassmorphisim(
      radius: 15.0,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: borderRadius(15.0),
          color: SwitchColors.mainColor,
          border: Border.all(
            color: SwitchColors.borderColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SingleInfoWidget(
              imagePath:
                  "assets/images/svg_images/weather_info/wind_degree.svg",
              percentage: windDirection(degree: degree),
              title: "Wind Direction",
            ),
            SingleInfoWidget(
              imagePath: "assets/images/svg_images/weather_info/visibility.svg",
              percentage: "$visibility m",
              title: "Visibility",
            ),
            SingleInfoWidget(
              imagePath: "assets/images/svg_images/weather_info/wind_speed.svg",
              percentage: "${speed.speedConvertor} $speedUnite",
              title: "Wind Speed",
            ),
          ],
        ),
      ),
    );
  }
}

class SingleInfoWidget extends StatelessWidget {
  const SingleInfoWidget({
    super.key,
    required this.imagePath,
    required this.percentage,
    required this.title,
  });

  final String imagePath;
  final String percentage;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: context.screenWidth * .15,
          height: context.screenHeight * .05,
          child: SvgPicture.asset(imagePath),
        ),
        const Gaps(hRatio: 0.01),
        Text(
          title,
          style: AppTextstyle.titleTextStyle,
        ),
        const Gaps(height: 6.0),
        Text(
          percentage,
          style: AppTextstyle.dataTextStyle,
        ),
      ],
    );
  }
}
