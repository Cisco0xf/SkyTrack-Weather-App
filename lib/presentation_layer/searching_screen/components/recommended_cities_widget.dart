import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:weatherapp/common/app_dimension.dart';
import 'package:weatherapp/common/commons.dart';
import 'package:weatherapp/common/navigat_to.dart';
import 'package:weatherapp/constants/app_colors.dart';
import 'package:weatherapp/presentation_layer/searching_screen/searching_details/searching_details_screen.dart';

import '../../../constants/gaps.dart';

class RecommendedCitiesListWidget extends StatelessWidget {
  const RecommendedCitiesListWidget({
    super.key,
    required this.recommendedList,
    required this.targetText,
  });

  final List<String> recommendedList;
  final String targetText;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(
          top: context.screenHeight * .01,
          bottom: context.screenHeight * .12,
        ),
        itemCount: recommendedList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5.0,
            ),
            decoration: BoxDecoration(
              borderRadius: borderRadius(15.0),
              color: SwitchColors.mainColor,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: borderRadius(15.0),
                onTap: () {
                  navigatTo(
                    rout: SearchingCityWeatherDataMainScreen(
                      cityName: recommendedList[index],
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 15.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const Icon(Icons.location_on),
                          const Gaps(wRatio: 0.02),
                          Text(
                            recommendedList[index],
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_outward_sharp,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

extension ColorImportantText on String {
  (String firstPart, String targetText, String lastPart) highLightText({
    required String targetText,
  }) {
    int startPattern = indexOf(targetText.toLowerCase());
    int endPattern = startPattern + targetText.length;
    String firstPart = "";
    String lastPart = "";
    if (startPattern == -1) {
      log("FullText : : $this");
      firstPart = "";
      lastPart = substring(endPattern + 1);
      return (firstPart, targetText, lastPart);
      //return ("", this, "");
    }
    firstPart = substring(0, startPattern);

    lastPart = substring(endPattern);

    return (firstPart, targetText, lastPart);
  }
}

//String lastPart = substring(startPattern).replaceFirst(targetText, "");
