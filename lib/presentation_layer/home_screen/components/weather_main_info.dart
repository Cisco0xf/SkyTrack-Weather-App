import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weatherapp/common/app_dimension.dart';
import 'package:weatherapp/common/glass_layer.dart';
import 'package:weatherapp/constants/app_colors.dart';
import 'package:weatherapp/constants/app_textstyle.dart';

class WeatherMainInfoWidget extends StatelessWidget {
  const WeatherMainInfoWidget({
    super.key,
    required this.pressure,
    required this.cloudsAll,
    required this.hamidity,
  });

  final int pressure;
  final int hamidity;
  final int cloudsAll;

  @override
  Widget build(BuildContext context) {
    return Glassmorphisim(
      radius: 15.0,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: SwitchColors.mainColor,
          border: Border.all(
            color: SwitchColors.borderColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            MainInfoItemWidget(
              title: "Humidity",
              imagePath: "assets/images/svg_images/weather_info/humidity.svg",
              weatherInfo: "$hamidity %",
            ),
            MainInfoItemWidget(
              title: "Pressure",
              imagePath: "assets/images/svg_images/weather_info/pressure.svg",
              weatherInfo: "$pressure hPa",
            ),
            MainInfoItemWidget(
              title: "Clouds",
              imagePath: "assets/images/svg_images/weather_info/clouds.svg",
              weatherInfo: "$cloudsAll %",
            ),
          ],
        ),
      ),
    );
  }
}

class MainInfoItemWidget extends StatelessWidget {
  const MainInfoItemWidget({
    super.key,
    required this.title,
    required this.imagePath,
    required this.weatherInfo,
  });
  final String imagePath;
  final String weatherInfo;
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
        SizedBox(
          height: context.screenHeight * .01,
        ),
        Text(
          weatherInfo,
          style: AppTextstyle.dataTextStyle,
        ),
        Text(
          title,
          style: AppTextstyle.titleTextStyle,
        ),
      ],
    );
  }
}
