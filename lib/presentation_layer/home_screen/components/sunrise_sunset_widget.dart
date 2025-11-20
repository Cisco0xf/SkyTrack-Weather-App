import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weatherapp/common/app_dimension.dart';
import 'package:weatherapp/common/glass_layer.dart';
import 'package:weatherapp/common/timestamp_format.dart';
import 'package:weatherapp/constants/app_colors.dart';
import 'package:weatherapp/constants/gaps.dart';

class SunriseSunsetDataWidget extends StatelessWidget {
  const SunriseSunsetDataWidget({
    super.key,
    required this.sunrise,
    required this.sunset,
  });

  final int sunset;
  final int sunrise;

  @override
  Widget build(BuildContext context) {
    return Glassmorphisim(
      radius: 15.0,
      child: Container(
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.all(15.0),
        height: context.screenHeight * .22,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: SwitchColors.mainColor,
          border: Border.all(
            color: SwitchColors.borderColor,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: SizedBox(
                width: context.screenWidth * .6,
                height: context.screenHeight * .1,
                child: SvgPicture.asset(
                  "assets/images/svg_images/weather_info/sys.svg",
                ),
              ),
            ),
            Positioned.fill(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SysInfoWidget(
                    imagePath:
                        "assets/images/svg_images/weather_info/sunrise.svg",
                    sysTime: sunrise.foramtTimesTampt,
                    sysTitle: "Surise",
                  ),
                  SysInfoWidget(
                    imagePath:
                        "assets/images/svg_images/weather_info/sunset.svg",
                    sysTime: sunset.foramtTimesTampt,
                    sysTitle: "Sunset",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SysInfoWidget extends StatelessWidget {
  const SysInfoWidget({
    super.key,
    required this.imagePath,
    required this.sysTime,
    required this.sysTitle,
  });
  final String imagePath;
  final String sysTitle;
  final String sysTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white30.withOpacity(0.5),
            borderRadius: BorderRadius.circular(5.0),
          ),
          width: context.screenWidth * .1,
          height: context.screenHeight * .05,
          child: SvgPicture.asset(imagePath),
        ),
        const Gaps(hRatio: 0.01),
        Column(
          children: <Widget>[
            Text(
              sysTitle,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              sysTime,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      ],
    );
  }
}
