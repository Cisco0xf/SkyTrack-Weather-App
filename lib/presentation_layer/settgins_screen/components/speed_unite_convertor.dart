import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/common/commons.dart';
import 'package:weatherapp/constants/app_colors.dart';
import 'package:weatherapp/constants/gaps.dart';
import 'package:weatherapp/presentation_layer/settgins_screen/select_item_widget.dart';
import 'package:weatherapp/statemanagement_layer/settings_state/change_theme_provider.dart';
import 'package:weatherapp/statemanagement_layer/settings_state/speed_convertor_provider.dart';

class SpeedConvertorWidget extends StatefulWidget {
  const SpeedConvertorWidget({super.key});

  @override
  State<SpeedConvertorWidget> createState() => _SpeedConvertorWidgetState();
}

class _SpeedConvertorWidgetState extends State<SpeedConvertorWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController doneController;
  @override
  initState() {
    doneController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();
    super.initState();
  }

  @override
  void dispose() {
    doneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChangeThemeProvider>(
      builder: (context, _, __) {
        return Consumer<SwitchSpeedUnit>(
          builder: (context, speed, _) {
            return Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: borderRadius(15.0),
                color: SwitchColors.mainColor,
              ),
              child: Column(
                children: <Widget>[
                  const Row(
                    children: <Widget>[
                      Gaps(wRatio: 0.03),
                      Text(
                        "Speed unite",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Gaps(hRatio: 0.01),
                  SelectUniteItemWidget(
                    isSelected: speed.isKmPh,
                    tempType: "kilometers per hour (km/h)",
                    onTap: () async {
                      await speed.switchSppedunit(true);
                      doneController.reset();
                      doneController.forward();
                    },
                    doneController: doneController,
                  ),
                  SelectUniteItemWidget(
                    isSelected: !speed.isKmPh,
                    tempType: "meters per second (m/s)",
                    onTap: () async {
                      await speed.switchSppedunit(false);
                      doneController.reset();
                      doneController.forward();
                    },
                    doneController: doneController,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
