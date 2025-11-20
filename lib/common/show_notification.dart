import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:weatherapp/common/navigator_key.dart';

void showToastification({
  required String title,
  bool showProgressBar = false,
  double textSize = 15,
  ToastificationType type = ToastificationType.info,
}) {
  final BuildContext context = navigationKey.currentContext as BuildContext;
  toastification.show(
    context: context,
    alignment: Alignment.topCenter,
    type: ToastificationType.info,
    description: Text(
      title,
      style: TextStyle(
        fontSize: textSize,
        fontWeight: FontWeight.bold,
      ),
    ),
    applyBlurEffect: true,
    showProgressBar: showProgressBar,
    dismissDirection: DismissDirection.horizontal,
    animationDuration: const Duration(milliseconds: 500),
    autoCloseDuration: const Duration(milliseconds: 2500),
  );
}
