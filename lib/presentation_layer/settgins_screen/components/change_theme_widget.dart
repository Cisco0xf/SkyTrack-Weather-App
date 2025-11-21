import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/common/app_dimension.dart';
import 'package:weatherapp/common/commons.dart';
import 'package:weatherapp/constants/app_colors.dart';
import 'package:weatherapp/constants/gaps.dart';
import 'package:weatherapp/statemanagement_layer/settings_state/change_theme_provider.dart';

class ChangeThemeWidget extends StatefulWidget {
  const ChangeThemeWidget({super.key});

  @override
  State<ChangeThemeWidget> createState() => _ChangeThemeWidgetState();
}

class _ChangeThemeWidgetState extends State<ChangeThemeWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _selectController;
  @override
  void initState() {
    _selectController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChangeThemeProvider>(
      builder: (context, background, _) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.all(10.0),
          height: context.screenHeight * .45,
          decoration: BoxDecoration(
            borderRadius: borderRadius(15.0),
            color: SwitchColors.mainColor,
          ),
          child: Column(
            children: <Widget>[
              const Row(
                children: <Widget>[
                  Gaps(wRatio: 0.02),
                  Text(
                    "App Theme",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              const Gaps(hRatio: 0.02),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SelectBackgroundWidget(
                        animationPath:
                            "assets/animations/animations/animated_bg_2.json",
                        isSelected: background.isFirstTheme,
                        selectController: _selectController,
                        onTap: () {
                          background.setFirstTheme;
                          _selectController.reset();
                          _selectController.forward();
                        },
                      ),
                      SelectBackgroundWidget(
                        animationPath:
                            "assets/animations/animations/animated_bg.json",
                        isSelected: background.isSecondTheme,
                        selectController: _selectController,
                        onTap: () {
                          background.setSecondTheme;
                          _selectController.reset();
                          _selectController.forward();
                        },
                      ),
                      SelectBackgroundWidget(
                        animationPath:
                            "assets/animations/animations/animated_bg_3.json",
                        isSelected: background.isThirdTheme,
                        selectController: _selectController,
                        onTap: () {
                          background.setThirdTheme;
                          _selectController.reset();
                          _selectController.forward();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SelectBackgroundWidget extends StatelessWidget {
  const SelectBackgroundWidget({
    super.key,
    required this.animationPath,
    required this.isSelected,
    required this.selectController,
    required this.onTap,
  });

  final String animationPath;
  final bool isSelected;
  final AnimationController selectController;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        InkWell(
          onTap: onTap,
          child: Container(
            width: context.screenWidth * .3,
            height: context.screenHeight * .28,
            margin: const EdgeInsets.symmetric(horizontal: 15.0),
            decoration: BoxDecoration(
              borderRadius: borderRadius(15.0),
              border: Border.all(
                color: isSelected ? Colors.white : const Color(0xFF000000),
                width: isSelected ? 2.0 : 1.0,
              ),
            ),
            child: ClipRRect(
              borderRadius: borderRadius(15.0),
              child: Lottie.asset(
                animationPath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        if (isSelected) ...{
          SizedBox(
            width: context.screenWidth * .3,
            height: context.screenHeight * .07,
            child: Lottie.asset(
              controller: selectController,
              "assets/animations/animations/done.json",
            ),
          )
        } else ...{
          SizedBox(
            width: context.screenWidth * .3,
            height: context.screenHeight * .07,
          )
        }
      ],
    );
  }
}
