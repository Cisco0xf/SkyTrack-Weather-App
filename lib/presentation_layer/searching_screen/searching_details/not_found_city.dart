import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weatherapp/common/app_dimension.dart';
import 'package:weatherapp/constants/gaps.dart';

class NotFoundCityWidget extends StatelessWidget {
  const NotFoundCityWidget({
    super.key,
    required this.cityName,
    this.isMap = false,
  });
  final String cityName;
  final bool isMap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Gaps(hRatio: 0.05),
        Row(
          children: <Widget>[
            const Gaps(wRatio: 0.02),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.black38.withOpacity(0.5),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),
            ),
          ],
        ),
        const Gaps(hRatio: 0.14),
        SizedBox(
          width: context.screenWidth * .8,
          height: context.screenHeight * .3,
          child: SvgPicture.asset(
            "assets/images/svg_images/not_found/not_found_city.svg",
          ),
        ),
        const Gaps(hRatio: 0.02),
        Text(
          "City \"$cityName\" Not found",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gaps(hRatio: 0.01),
        Text(
          !isMap
              ? "Please make sur to write the city name in correct way or you can pick its location from the Map"
              : "Please Choose another point for this City",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
          ),
        )
      ],
    );
  }
}
