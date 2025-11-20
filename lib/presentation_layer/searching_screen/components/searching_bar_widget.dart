import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weatherapp/common/app_dimension.dart';
import 'package:weatherapp/common/navigat_to.dart';
import 'package:weatherapp/constants/gaps.dart';
import 'package:weatherapp/presentation_layer/searching_screen/components/pick_location_map_widget.dart';
import 'package:weatherapp/presentation_layer/searching_screen/searching_details/searching_details_screen.dart';
import 'package:weatherapp/statemanagement_layer/settings_state/change_theme_provider.dart';

typedef SearchingCity = void Function(String?);

class SearchingBarWidget extends StatelessWidget {
  const SearchingBarWidget({
    super.key,
    required this.onChanged,
    required this.searchingCityController,
  });

  final SearchingCity onChanged;
  final TextEditingController searchingCityController;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: context.screenHeight * .07,
            width: context.screenWidth * .75,
            child: TextField(
              controller: searchingCityController,
              keyboardType: TextInputType.text,
              onChanged: onChanged,
              onSubmitted: (city) {
                log("OnSumitted method city : $city");
                navigatTo(
                  rout: SearchingCityWeatherDataMainScreen(
                    cityName: city,
                  ),
                );
              },
              textInputAction: TextInputAction.search,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(30),
              ],
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    color: Color(0xFFF5EFFF),
                    width: 1.2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    color: Color(0xFFA594F9),
                    width: 2.2,
                  ),
                ),
                prefixIcon: const Icon(
                  Icons.location_on_sharp,
                ),
                filled: true,
                fillColor: const Color(0xFFE5D9F2),
                hintText: "Cairo",
                hintStyle: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
              ),
            ),
          ),
          const Gaps(wRatio: 0.02),
          Container(
            margin: const EdgeInsets.all(5.0),
            height: context.screenHeight * .07,
            width: context.screenWidth * .15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: !context.isLight
                  ? Colors.black.withOpacity(0.7)
                  : Colors.white54.withOpacity(0.5),
              border: Border.all(
                color: const Color(0xFFF5EFFF),
                width: 1.2,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10.0),
                onTap: () {
                  navigatTo(
                    rout: const PickLocationFromMapWidget(),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Icon(
                    Icons.location_on,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
