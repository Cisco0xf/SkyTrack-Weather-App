import 'package:flutter/material.dart';
import 'package:weatherapp/presentation_layer/home_screen/home_screen.dart';
import 'package:weatherapp/presentation_layer/next_forcecase_screen/main_fcecase_screen.dart';
import 'package:weatherapp/presentation_layer/searching_screen/main_searching_screen.dart';
import 'package:weatherapp/presentation_layer/settgins_screen/settings_main_screen.dart';

class CurrentScreenModel {
  final String title;
  final String animation;

  final Widget target;

  const CurrentScreenModel({
    required this.animation,
    required this.title,
    required this.target,
  });
}

List<CurrentScreenModel> currentScreenmodel = const <CurrentScreenModel>[
  CurrentScreenModel(
    animation: "assets/animations/home.json",
    title: "Home",
    target: HomeScreen(),
  ),
  CurrentScreenModel(
    animation: "assets/animations/loading.json",
    title: "Home",
    target: MainForcecaseScreen(),
  ),
  CurrentScreenModel(
    animation: "assets/animations/search.json",
    target: MainSearchingScreen(),
    title: "Search",
  ),
  CurrentScreenModel(
    animation: "assets/animations/settings.json",
    title: "Settings",
    target: SettingsMainScreen(),
  ),
];
