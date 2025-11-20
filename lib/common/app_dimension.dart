import 'package:flutter/material.dart';

extension AppDimension on BuildContext {
  double get screenWidth {
    double width = MediaQuery.of(this).size.width;
    return width;
  }

  double get screenHeight {
    double height = MediaQuery.of(this).size.height;
    return height;
  }
}
