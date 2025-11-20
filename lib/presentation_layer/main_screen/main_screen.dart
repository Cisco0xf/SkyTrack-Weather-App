import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/common/app_dimension.dart';
import 'package:weatherapp/presentation_layer/main_screen/current_screen.dart';
import 'package:weatherapp/presentation_layer/main_screen/custom_bottom_navigation.dart';
import 'package:weatherapp/presentation_layer/main_screen/error_widget.dart';
import 'package:weatherapp/presentation_layer/main_screen/show_exit_dialog.dart';
import 'package:weatherapp/statemanagement_layer/fetch_weather_data/fetch_weather_data.dart';
import 'package:weatherapp/statemanagement_layer/select_current_content/select_current_content_provider.dart';
import 'package:weatherapp/statemanagement_layer/settings_state/change_theme_provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final FetchWeatherProvider fetchWeather;

  @override
  void initState() {
    fetchWeather = Provider.of<FetchWeatherProvider>(context, listen: false)
      ..updateWeatherData(updateUi: false);

    super.initState();
  }

  bool isPoped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Consumer<ChangeThemeProvider>(
        builder: (context, _, __) {
          return Consumer<SelectCurrentContentProvider>(
            builder: (context, currentContent, _) {
              return PopScope(
                canPop: false,
                onPopInvokedWithResult: (didPop, result) async {
                  bool isHome = currentContent.currentContent == 0;
                  if (!isHome) {
                    currentContent.setFirstContent;
                    return;
                  }

                  if (!didPop) {
                    await showExitDialog;

                    return;
                  }

                  if (context.mounted && isPoped) {
                    Navigator.pop(context);
                  }
                },
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    // Animated Background
                    Positioned.fill(
                      child: Lottie.asset(
                        mainScreenAnimatedBG,
                        fit: BoxFit.cover,
                      ),
                    ),

                    Positioned.fill(
                      child: Consumer<FetchWeatherProvider>(
                        builder: (context, weather, child) {
                          if (weather.isLoading) {
                            return Center(
                              child: Container(
                                padding: const EdgeInsets.all(15.0),
                                width: context.screenWidth * .35,
                                height: context.screenHeight * .15,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.black45.withOpacity(0.5),
                                ),
                                child: Lottie.asset(
                                  "assets/animations/animations/clouds_laoding.json",
                                ),
                              ),
                            );
                          }

                          if (weather.hasError) {
                            return MainScreenErrorWidget(
                              animationPath:
                                  "assets/animations/internet_error.json",
                              title: "Something goes wrong",
                              description:
                                  "Please check yor internet connection, and the location permission then pull to refresh",
                              onRefresh: () async {
                                /* setState(
                                    () {
                                      weatherData = fetchAllWeatherData;
                                    },
                                  ); */
                              },
                            );
                          }

                          return Consumer<SelectCurrentContentProvider>(
                            builder: (context, value, child) {
                              final int currentIndex = value.currentContent;
                              return currentScreenmodel[currentIndex].target;
                            },
                          );
                        },
                      ),
                    ),

                    // Custom Navigation Bar
                    Positioned(
                      bottom: context.screenHeight * .01,
                      right: 10,
                      left: 10,
                      child: const CustomBottomNavigationWidget(),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
