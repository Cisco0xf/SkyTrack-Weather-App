import 'package:flutter/material.dart';
import 'package:weatherapp/common/app_dimension.dart';
import 'package:weatherapp/common/navigat_to.dart';
import 'package:weatherapp/common/navigator_key.dart';
import 'package:weatherapp/constants/app_colors.dart';
import 'package:weatherapp/presentation_layer/searching_screen/searching_details/searching_details_screen.dart';

Future<void> showWeatherDataDialog({
  required String cityName,
}) async {
  final BuildContext context = navigationKey.currentContext!;
  await showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      return const SizedBox();
    },
    transitionBuilder: (context, animation, secondaryAnimation, _) {
      return ScaleTransition(
        scale: Tween<double>(
          begin: 0.5,
          end: 1.0,
        ).animate(animation),
        child: FadeTransition(
          opacity: Tween<double>(
            begin: 0.5,
            end: 1.0,
          ).animate(animation),
          child: Dialog(
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Icon(
                    Icons.location_on,
                    size: 40,
                  ),
                  Text(
                    "Would you like to pick the Weather data of \"$cityName\" City",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                        width: context.screenWidth * .42,
                        height: context.screenHeight * .07,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: const BorderSide(
                                color: AppColorsLightMode.subColor,
                              ),
                            ),
                          ),
                          child: const Text(
                            "Another location",
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: context.screenWidth * .42,
                        height: context.screenHeight * .07,
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                            navigatTo(
                              rout: SearchingCityWeatherDataMainScreen(
                                cityName: cityName,
                                isMap: true,
                              ),
                            );
                          },
                          color: AppColorsLightMode.subColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(Icons.cloud_done_rounded),
                              Text("Get Weather"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
