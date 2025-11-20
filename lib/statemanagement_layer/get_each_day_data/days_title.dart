import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/common/navigator_key.dart';
import 'package:weatherapp/statemanagement_layer/get_each_day_data/each_day_data_provider.dart';

final BuildContext context = navigationKey.currentContext!;

EachDayDataProvider get day => Provider.of<EachDayDataProvider>(context, listen: false,);

List<String> monddayStart = <String>[
  "Mon",
  "Tue",
  "Wed",
  "Thu",
  "Fri",
  "Sat",
];
List<double> mondayAvrageTemp = <double>[
  day.mondayAvargeTemp,
  day.tuesdayAvargeTemp,
  day.wendesdayAvargeTemp,
  day.thursdayAvargeTemp,
  day.fridayAvargeTemp,
  day.saturdayAvargeTemp,
];
List<String> tuesdayStart = <String>[
  "Tue",
  "Wed",
  "Thu",
  "Fri",
  "Sat",
  "Sun",
];
List<double> tuesdayAvrageTemp = <double>[
  day.tuesdayAvargeTemp,
  day.wendesdayAvargeTemp,
  day.thursdayAvargeTemp,
  day.fridayAvargeTemp,
  day.saturdayAvargeTemp,
  day.sundayAvargeTemp,
];
List<String> wendesayStart = <String>[
  "Wed",
  "Thu",
  "Fri",
  "Sat",
  "Sun",
  "Mon",
];
List<double> wendesdayAvrageTemp = <double>[
  day.wendesdayAvargeTemp,
  day.thursdayAvargeTemp,
  day.fridayAvargeTemp,
  day.saturdayAvargeTemp,
  day.sundayAvargeTemp,
  day.mondayAvargeTemp,
];
List<String> thursdayStart = <String>[
  "Thu",
  "Fri",
  "Sat",
  "Sun",
  "Mon",
  "Tue",
];
List<double> thursAvrageTemp = <double>[
  day.thursdayAvargeTemp,
  day.fridayAvargeTemp,
  day.saturdayAvargeTemp,
  day.sundayAvargeTemp,
  day.mondayAvargeTemp,
  day.tuesdayAvargeTemp,
];
List<String> fridayStart = <String>[
  "Fri",
  "Sat",
  "Sun",
  "Mon",
  "Tue",
  "Wed",
];
List<double> fridayAvrageTemp = <double>[
  day.fridayAvargeTemp,
  day.saturdayAvargeTemp,
  day.sundayAvargeTemp,
  day.mondayAvargeTemp,
  day.tuesdayAvargeTemp,
  day.wendesdayAvargeTemp,
];
List<String> saturdayStart = <String>[
  "Sat",
  "Sun",
  "Mon",
  "Tue",
  "Wed",
  "Thu",
];
List<double> saturdayAvrageTemp = <double>[
  day.saturdayAvargeTemp,
  day.sundayAvargeTemp,
  day.mondayAvargeTemp,
  day.tuesdayAvargeTemp,
  day.wendesdayAvargeTemp,
  day.thursdayAvargeTemp,
];
List<String> sundayStart = <String>[
  "Sun",
  "Mon",
  "Tue",
  "Wed",
  "Thu",
  "Fri",
];
List<double> sundayAvrageTemp = <double>[
  day.sundayAvargeTemp,
  day.mondayAvargeTemp,
  day.tuesdayAvargeTemp,
  day.wendesdayAvargeTemp,
  day.thursdayAvargeTemp,
  day.fridayAvargeTemp,
];
