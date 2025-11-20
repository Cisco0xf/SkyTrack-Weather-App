import 'package:flutter/material.dart';
import 'package:weatherapp/common/app_dimension.dart';

class Gaps extends StatelessWidget {
  const Gaps({
    super.key,
    this.hRatio,
    this.wRatio,
    this.height = 0.0,
    this.width = 0.0,
  });

  final double? wRatio;
  final double? hRatio;

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: hRatio != null ? context.screenHeight * hRatio! : height,
      width: wRatio != null ? context.screenWidth * wRatio! : width,
    );
  }
}
