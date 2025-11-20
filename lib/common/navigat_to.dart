import 'package:flutter/material.dart';
import 'package:weatherapp/common/navigator_key.dart';

void navigatTo({
  required Widget rout,
}) {
  final BuildContext context = navigationKey.currentContext!;
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) {
        return rout;
      },
    ),
  );
}
