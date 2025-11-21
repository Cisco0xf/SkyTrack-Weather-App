import 'package:flutter/material.dart';
import 'package:weatherapp/common/commons.dart';
import 'package:weatherapp/constants/app_colors.dart';
import 'package:weatherapp/constants/gaps.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.cityName,
  });

  final String cityName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Gaps(hRatio: 0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Gaps(wRatio: 0.03),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      borderRadius: borderRadius(5.0),
                      color: SwitchColors.mainColor,
                    ),
                    child: const Icon(
                      Icons.location_on,
                      size: 30,
                    ),
                  ),
                ),
                const Gaps(wRatio: 0.03),
                Text(
                  cityName,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
