import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/common/app_dimension.dart';
import 'package:weatherapp/common/commons.dart';
import 'package:weatherapp/constants/app_colors.dart';

class SelectUniteItemWidget extends StatelessWidget {
  const SelectUniteItemWidget({
    super.key,
    required this.isSelected,
    required this.tempType,
    required this.onTap,
    required this.doneController,
  });
  final String tempType;
  final bool isSelected;
  final void Function() onTap;
  final AnimationController doneController;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.all(8.0),
      duration: const Duration(
        milliseconds: 400,
      ),
      decoration: BoxDecoration(
        borderRadius: borderRadius(8.0),
        color: isSelected ? AppColorsLightMode.subColor.withOpacity(0.3) : null,
        border: Border.all(
          color: isSelected ? Colors.white : Colors.grey,
          width: 1.2,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: borderRadius(8.0),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  tempType,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: context.screenWidth * .15,
                  height: context.screenHeight * .04,
                  child: isSelected
                      ? Lottie.asset(
                          controller: doneController,
                          "assets/animations/animations/done_1.json",
                        )
                      : const SizedBox.shrink(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
