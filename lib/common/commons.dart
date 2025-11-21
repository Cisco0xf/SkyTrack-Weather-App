import 'package:flutter/material.dart';

enum From {
  horizontal,
  vertical,
  all,
}

enum Side {
  top,
  right,
  bottom,
  left,
  all,
}

EdgeInsetsGeometry padding(double padding, {From from = From.all}) {
  switch (from) {
    case From.all:
      {
        return EdgeInsets.all(padding);
      }
    case From.horizontal:
      {
        return EdgeInsets.symmetric(horizontal: padding);
      }
    case From.vertical:
      {
        return EdgeInsets.symmetric(vertical: padding);
      }
  }
}

BorderRadius borderRadius(double radius, {Side side = Side.all}) {
  switch (side) {
    case Side.top:
      {
        return BorderRadius.vertical(top: Radius.circular(radius));
      }
    case Side.bottom:
      {
        return BorderRadius.vertical(bottom: Radius.circular(radius));
      }
    case Side.left:
      {
        return BorderRadius.horizontal(left: Radius.circular(radius));
      }
    case Side.right:
      {
        return BorderRadius.horizontal(right: Radius.circular(radius));
      }
    case Side.all:
      {
        return BorderRadius.circular(radius);
      }
  }
}

class Clicker extends StatelessWidget {
  const Clicker({
    super.key,
    this.radius = 10.0,
    required this.child,
    required this.onClick,
    this.isClircle = false,
    this.innerPadding = 10.0,
  });

  final void Function() onClick;
  final double innerPadding;
  final bool isClircle;
  final double radius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onClick,
        borderRadius: isClircle ? null : BorderRadius.circular(radius),
        customBorder: isClircle ? const CircleBorder() : null,
        child: Padding(
          padding: padding(innerPadding),
          child: child,
        ),
      ),
    );
  }
}
