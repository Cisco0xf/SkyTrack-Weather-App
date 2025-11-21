import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/common/app_dimension.dart';
import 'package:weatherapp/common/commons.dart';
import 'package:weatherapp/common/glass_layer.dart';
import 'package:weatherapp/constants/app_colors.dart';
import 'package:weatherapp/constants/gaps.dart';
import 'package:weatherapp/presentation_layer/main_screen/current_screen.dart';
import 'package:weatherapp/statemanagement_layer/select_current_content/select_current_content_provider.dart';

class CustomBottomNavigationWidget extends StatefulWidget {
  const CustomBottomNavigationWidget({super.key});

  @override
  State<CustomBottomNavigationWidget> createState() =>
      _CustomBottomNavigationWidgetState();
}

class _CustomBottomNavigationWidgetState
    extends State<CustomBottomNavigationWidget> with TickerProviderStateMixin {
  late final AnimationController _homeController;
  late final AnimationController _searchingController;
  late final AnimationController _settingsController;
  late final AnimationController _forcecaseController;

  late List<AnimationController> controllers;

  @override
  initState() {
    _homeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _searchingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _settingsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _forcecaseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    controllers = <AnimationController>[
      _homeController,
      _forcecaseController,
      _searchingController,
      _settingsController,
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Glassmorphisim(
      radius: 15.0,
      child: Container(
        height: context.screenHeight * .08,
        decoration: BoxDecoration(
          color: const Color(0xFF7f6fba).withOpacity(0.7),
          borderRadius: borderRadius(30.0),
          border: Border.all(color: SwitchColors.borderColor),
        ),
        child: Consumer<SelectCurrentContentProvider>(
          builder: (context, currentContent, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ...List.generate(
                  currentScreenmodel.length,
                  (index) {
                    return BottomNavItemWidget(
                      animation: currentScreenmodel[index].animation,
                      isSelected: currentContent.currentContent == index,
                      iconController: controllers[index],
                      onTap: () {
                        currentContent.selectCurrentContent(
                            selectedIndex: index);
                        controllers[index].reset();
                        controllers[index].forward();
                      },
                    );
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class BottomNavItemWidget extends StatelessWidget {
  const BottomNavItemWidget({
    super.key,
    required this.animation,
    required this.isSelected,
    required this.onTap,
    required this.iconController,
  });
  final String animation;
  final bool isSelected;
  final void Function() onTap;
  final AnimationController iconController;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        child: SizedBox(
          width: context.screenWidth * .2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 25,
                height: 25,
                child: Lottie.asset(
                  animation,
                  controller: iconController,
                ),
              ),
              if (isSelected) ...{
                const Gaps(height: 6.0),
                TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 350),
                  tween:
                      Tween<double>(begin: 0.0, end: context.screenWidth * .1),
                  builder: (context, value, child) {
                    return Container(
                      width: isSelected ? value : 0.0,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: borderRadius(5.0),
                        color: AppColorsLightMode.subColor,
                      ),
                    );
                  },
                ),
              }
            ],
          ),
        ),
      ),
    );
  }
}
