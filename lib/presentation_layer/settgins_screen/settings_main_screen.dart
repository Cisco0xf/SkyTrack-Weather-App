import 'package:flutter/material.dart';
import 'package:weatherapp/constants/gaps.dart';
import 'package:weatherapp/presentation_layer/settgins_screen/components/change_theme_widget.dart';
import 'package:weatherapp/presentation_layer/settgins_screen/components/dev_section.dart';
import 'package:weatherapp/presentation_layer/settgins_screen/components/speed_unite_convertor.dart';
import 'package:weatherapp/presentation_layer/settgins_screen/components/temp_unite_convertor.dart';

class SettingsMainScreen extends StatelessWidget {
  const SettingsMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        Gaps(hRatio: 0.06),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Gaps(wRatio: 0.02),
            Text(
              "Weather Settings",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Gaps(hRatio: 0.01),
                SelectTempretureUniteWidget(),
                Divider(),
                SpeedConvertorWidget(),
                Divider(),
                ChangeThemeWidget(),
                DevSection(),
                Gaps(hRatio: 0.12),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
