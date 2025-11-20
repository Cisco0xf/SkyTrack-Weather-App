import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/common/celsius_convertor.dart';
import 'package:weatherapp/common/date_foramt.dart';
import 'package:weatherapp/common/navigator_key.dart';
import 'package:weatherapp/data_layer/models/forcecase_models/next_forcecase_data/next_forcecase_main_data.dart';
import 'package:weatherapp/statemanagement_layer/fetch_weather_data/fetch_weather_data.dart';

class EachDayDataProvider with ChangeNotifier {
  // Get the context for the Provider
  final BuildContext context = navigationKey.currentContext!;

  // Access the data from the Provider

  FetchWeatherProvider get accessedData => Provider.of<FetchWeatherProvider>(
        context,
        listen: false,
      );

  List<NextForcecaseData> get globalForcecaseData =>
      accessedData.forecast!.forcecaseDataList;

  // Each day Data List

  List<NextForcecaseData> mondyData = <NextForcecaseData>[];
  List<NextForcecaseData> tuesyData = <NextForcecaseData>[];
  List<NextForcecaseData> wendesyData = <NextForcecaseData>[];
  List<NextForcecaseData> thursayData = <NextForcecaseData>[];
  List<NextForcecaseData> firdayData = <NextForcecaseData>[];
  List<NextForcecaseData> saturyData = <NextForcecaseData>[];
  List<NextForcecaseData> sundayData = <NextForcecaseData>[];

  List<List<NextForcecaseData>> get forcecaseDailyData =>
      <List<NextForcecaseData>>[
        mondyData,
        tuesyData,
        wendesyData,
        thursayData,
        firdayData,
        saturyData,
        sundayData,
      ];

  // Each Day total tempreture

  double mondayTotalTemp = 0.0;
  double tuesdayTotalTemp = 0.0;
  double wendesdayTotalTemp = 0.0;
  double thursdayTotalTemp = 0.0;
  double fridayTotalTemp = 0.0;
  double saturdayTotalTemp = 0.0;
  double sundayTotalTemp = 0.0;

  // Each Dat avrage tempreture

  double mondayAvargeTemp = 0.0;
  double tuesdayAvargeTemp = 0.0;
  double wendesdayAvargeTemp = 0.0;
  double thursdayAvargeTemp = 0.0;
  double fridayAvargeTemp = 0.0;
  double saturdayAvargeTemp = 0.0;
  double sundayAvargeTemp = 0.0;

  List<double> get daysAvargeTemp => <double>[
        mondayAvargeTemp,
        tuesdayAvargeTemp,
        wendesdayAvargeTemp,
        thursdayAvargeTemp,
        fridayAvargeTemp,
        saturdayAvargeTemp,
        sundayAvargeTemp,
      ];

  // Tempreture visualization titles

  List<String> daysTitlesList = <String>[
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  // Each Daya timesTemp
  int mondayTimesTem = 0;
  int tuesdayTimesTem = 0;
  int wendesdayTimesTem = 0;
  int thursdayTimesTem = 0;
  int fridayTimesTem = 0;
  int saturdayTimesTem = 0;
  int sundayTimesTem = 0;

  List<int> get dailyTimesTemp => <int>[
        mondayTimesTem,
        tuesdayTimesTem,
        wendesdayTimesTem,
        thursdayTimesTem,
        fridayTimesTem,
        saturdayTimesTem,
        sundayTimesTem,
      ];

  // Reset DataStructure to sort new data

  void _resetDataLists() {
    mondyData.clear();
    tuesyData.clear();
    wendesyData.clear();
    thursayData.clear();
    firdayData.clear();
    saturyData.clear();
    sundayData.clear();
    // Each Day total tempreture

    mondayTotalTemp = 0.0;
    tuesdayTotalTemp = 0.0;
    wendesdayTotalTemp = 0.0;
    thursdayTotalTemp = 0.0;
    fridayTotalTemp = 0.0;
    saturdayTotalTemp = 0.0;
    sundayTotalTemp = 0.0;

    // Each Dat avrage tempreture

    mondayAvargeTemp = 0.0;
    tuesdayAvargeTemp = 0.0;
    wendesdayAvargeTemp = 0.0;
    thursdayAvargeTemp = 0.0;
    fridayAvargeTemp = 0.0;
    saturdayAvargeTemp = 0.0;
    sundayAvargeTemp = 0.0;
    log("Daily Lists Data is Cleared");
  }

  void sortEachDayData(
      /* {required List<NextForcecaseData> globalForcecaseData} */) {
    _resetDataLists();
    for (int i = 0; i < globalForcecaseData.length; i++) {
      int timesTempDate = globalForcecaseData[i].dataDate;

      String dayText = timesTempDate.formateTimeTemps.formatedDate(
        format: "EEEE",
      );

      try {
        switch (dayText) {
          case "Monday":
            {
              mondyData.add(globalForcecaseData[i]);
              mondayTotalTemp += globalForcecaseData[i].mainData.tempreture;
              mondayAvargeTemp = mondayTotalTemp / mondyData.length;
              mondayTimesTem = globalForcecaseData[i].dataDate;
              //daysAvargeTemp = mondayAvrageTemp;
              //notifyListeners();
              break;
            }
          case "Tuesday":
            {
              tuesyData.add(globalForcecaseData[i]);
              tuesdayTotalTemp += globalForcecaseData[i].mainData.tempreture;
              tuesdayAvargeTemp = tuesdayTotalTemp / tuesyData.length;
              tuesdayTimesTem = globalForcecaseData[i].dataDate;
              //daysAvargeTemp = tuesdayAvrageTemp;
              //notifyListeners();
              break;
            }
          case "Wednesday":
            {
              wendesyData.add(globalForcecaseData[i]);
              wendesdayTotalTemp += globalForcecaseData[i].mainData.tempreture;
              wendesdayAvargeTemp = wendesdayTotalTemp / wendesyData.length;
              wendesdayTimesTem = globalForcecaseData[i].dataDate;
              //daysAvargeTemp = wendesdayAvrageTemp;
              //notifyListeners();
              break;
            }
          case "Thursday":
            {
              thursayData.add(globalForcecaseData[i]);
              thursdayTotalTemp += globalForcecaseData[i].mainData.tempreture;
              thursdayAvargeTemp = thursdayTotalTemp / thursayData.length;
              thursdayTimesTem = globalForcecaseData[i].dataDate;
              //daysAvargeTemp = thursAvrageTemp;
              //notifyListeners();
              break;
            }
          case "Friday":
            {
              firdayData.add(globalForcecaseData[i]);
              fridayTotalTemp += globalForcecaseData[i].mainData.tempreture;
              fridayAvargeTemp = fridayTotalTemp / firdayData.length;
              fridayTimesTem = globalForcecaseData[i].dataDate;
              //daysAvargeTemp = fridayAvrageTemp;
              //notifyListeners();
              break;
            }
          case "Saturday":
            {
              saturyData.add(globalForcecaseData[i]);
              saturdayTotalTemp += globalForcecaseData[i].mainData.tempreture;
              saturdayAvargeTemp = saturdayTotalTemp / saturyData.length;
              saturdayTimesTem = globalForcecaseData[i].dataDate;
              //daysAvargeTemp = saturdayAvrageTemp;
              //notifyListeners();
              break;
            }
          case "Sunday":
            {
              sundayData.add(globalForcecaseData[i]);
              sundayTotalTemp += globalForcecaseData[i].mainData.tempreture;
              sundayAvargeTemp = sundayTotalTemp / sundayData.length;
              sundayTimesTem = globalForcecaseData[i].dataDate;
              //daysAvargeTemp = sundayAvrageTemp;
              //notifyListeners();
              break;
            }
          default:
            {
              log("Error while adding the data to the days list");
            }
        }
      } catch (error) {
        log("You Fucked Up : $error");
      }
    }
    debugDaysData();
  }

  // Debug Data

  void debugDaysData() {
    log("${"*" * 25} Days Data ${"*" * 25}");

    log("Date Tmies Temps : $dailyTimesTemp");

    for (int i = 0; i < daysTitlesList.length; i++) {
      log("${"*" * 25} ${daysTitlesList[i]} Data ${"*" * 25}");
      log("${daysTitlesList[i]} Data Length : ${forcecaseDailyData[i].length}");
      log("${daysTitlesList[i]} Avarage Tempreture : ${daysAvargeTemp[i]}");
      log("${daysTitlesList[i]} Avarage Tempreture C : ${daysAvargeTemp[i].celsiusConvertor}");
      for (int j = 0; j < forcecaseDailyData[i].length; j++) {
        log("${daysTitlesList[i]} tempretur $j : ${forcecaseDailyData[i][j].mainData.tempreture}");
      }
    }
  }
}
