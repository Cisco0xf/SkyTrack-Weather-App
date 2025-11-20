import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/common/app_dimension.dart';
import 'package:weatherapp/constants/gaps.dart';
import 'package:weatherapp/data_layer/cities_list/cities_list.dart';
import 'package:weatherapp/presentation_layer/searching_screen/components/recommended_cities_widget.dart';
import 'package:weatherapp/presentation_layer/searching_screen/components/searching_bar_widget.dart';

class MainSearchingScreen extends StatefulWidget {
  const MainSearchingScreen({super.key});

  @override
  State<MainSearchingScreen> createState() => _MainSearchingScreenState();
}

class _MainSearchingScreenState extends State<MainSearchingScreen> {
  late final TextEditingController _searchCityControlller;

  @override
  void initState() {
    _searchCityControlller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchCityControlller.dispose();

    super.dispose();
  }

  List<String> recommendedCitiesList = List.from(worldCitiesnames);

  void get filterWorldCities {
    setState(
      () {
        recommendedCitiesList = worldCitiesnames
            .where(
              (city) {
                return city.toLowerCase().contains(
                      _searchCityControlller.text.toLowerCase(),
                    );
              },
            )
            .toSet()
            .toList();
      },
    );
  }

  bool get isUserSearching {
    bool isSeaching = _searchCityControlller.text.isNotEmpty;
    return isSeaching;
  }

  bool get isNotFoundCity {
    bool isNotEmpty = _searchCityControlller.text.isNotEmpty;
    bool isListEmpty = recommendedCitiesList.isEmpty;

    bool isNotFound = isNotEmpty && isListEmpty;

    return isNotFound;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(
          FocusNode(),
        );
      },
      child: Column(
        children: <Widget>[
          const Gaps(hRatio: 0.05),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Gaps(wRatio: 0.03),
              Text(
                "Search Weather",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Gaps(hRatio: 0.02),
          SearchingBarWidget(
            onChanged: (city) {
              filterWorldCities;
              log("Current Text: $city");
              log("Length of recommended cities :${recommendedCitiesList.length}");
            },
            searchingCityController: _searchCityControlller,
          ),
          if (!isUserSearching) ...{
            const StartSearchingWeatherWidget(),
          } else ...{
            RecommendedCitiesListWidget(
              recommendedList: recommendedCitiesList,
              targetText: _searchCityControlller.text,
            ),
          }
        ],
      ),
    );
  }
}

class StartSearchingWeatherWidget extends StatelessWidget {
  const StartSearchingWeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Gaps(hRatio: 0.14),
        SizedBox(
          width: context.screenWidth * .8,
          height: context.screenHeight * .3,
          child: Lottie.asset("assets/animations/search_weather.json"),
        ),
        const Text(
          "Search Weather in other cities",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
