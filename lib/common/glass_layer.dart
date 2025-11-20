import 'dart:ui';

import 'package:flutter/material.dart';

class Glassmorphisim extends StatelessWidget {
  const Glassmorphisim({
    super.key,
    required this.child,
    required this.radius,
  });

  final Widget child;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          child: child,
        ),
      ),
    );
  }
}
