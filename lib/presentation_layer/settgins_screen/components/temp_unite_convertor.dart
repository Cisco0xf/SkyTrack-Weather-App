import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/constants/app_colors.dart';
import 'package:weatherapp/constants/gaps.dart';
import 'package:weatherapp/presentation_layer/settgins_screen/select_item_widget.dart';
import 'package:weatherapp/statemanagement_layer/settings_state/change_theme_provider.dart';
import 'package:weatherapp/statemanagement_layer/settings_state/temp_convertor_provider.dart';

class SelectTempretureUniteWidget extends StatefulWidget {
  const SelectTempretureUniteWidget({super.key});

  @override
  State<SelectTempretureUniteWidget> createState() =>
      _SelectTempretureUniteWidgetState();
}

class _SelectTempretureUniteWidgetState
    extends State<SelectTempretureUniteWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController doneController;
  @override
  void initState() {
    doneController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );
    doneController.forward();
    super.initState();
  }

  @override
  void dispose() {
    doneController.dispose();
    super.dispose();
  }

  void _doneAnimation() {
    doneController.reset();
    doneController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChangeThemeProvider>(builder: (context, _, __) {
      return Consumer<SwitchTemUnitProvider>(
        builder: (context, convertTemp, _) {
          return Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: SwitchColors.mainColor,
                ),
                child: Column(
                  children: <Widget>[
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Gaps(wRatio: 0.03),
                        Text(
                          "Temperature unite",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Gaps(hRatio: 0.01),
                    SelectUniteItemWidget(
                      isSelected: convertTemp.isCelsuis,
                      tempType: "Celsius",
                      onTap: () async {
                        await convertTemp.switchTempUnit(true);
                        _doneAnimation();
                      },
                      doneController: doneController,
                    ),
                    SelectUniteItemWidget(
                      isSelected: !convertTemp.isCelsuis,
                      tempType: "Fahrenheit",
                      onTap: () async {
                        await convertTemp.switchTempUnit(false);
                        _doneAnimation();
                      },
                      doneController: doneController,
                    ),
                  ],
                ),
              )
            ],
          );
        },
      );
    });
  }
}
