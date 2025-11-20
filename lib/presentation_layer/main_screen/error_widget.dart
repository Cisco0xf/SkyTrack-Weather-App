import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/common/app_dimension.dart';
import 'package:weatherapp/constants/gaps.dart';

class MainScreenErrorWidget extends StatelessWidget {
  const MainScreenErrorWidget({
    super.key,
    required this.title,
    required this.animationPath,
    required this.description,
    required this.onRefresh,
  });
  final String animationPath;
  final String title;
  final String description;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        children: <Widget>[
          const Gaps(hRatio: 0.14),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  width: context.screenWidth * .9,
                  height: context.screenHeight * .3,
                  child: Lottie.asset(animationPath),
                ),
                const Gaps(hRatio: 0.01),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gaps(hRatio: 0.01),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Gaps(hRatio: 0.5),
        ],
      ),
    );
  }
}
