import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weatherapp/common/app_dimension.dart';
import 'package:weatherapp/common/commons.dart';
import 'package:weatherapp/common/navigator_key.dart';
import 'package:weatherapp/constants/gaps.dart';
import 'package:weatherapp/statemanagement_layer/settings_state/change_theme_provider.dart';

Future<void> get showExitDialog async {
  final BuildContext context = navigationKey.currentContext!;
  await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius(10.0),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                "Would you like to exit the app ?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gaps(hRatio: 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(
                    width: context.screenWidth * .3,
                    height: context.screenHeight * .06,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: borderRadius(15.0),
                        ),
                      ),
                      child: const Text("Cancel"),
                    ),
                  ),
                  SizedBox(
                    width: context.screenWidth * .3,
                    height: context.screenHeight * .06,
                    child: MaterialButton(
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: borderRadius(15.0),
                      ),
                      color: context.isLight
                          ? const Color(0xFF8B93FF)
                          : const Color(0xFF1C1678),
                      child: const Text("Exit"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
