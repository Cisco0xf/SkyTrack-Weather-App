import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/common/app_dimension.dart';
import 'package:weatherapp/common/celsius_convertor.dart';
import 'package:weatherapp/common/date_foramt.dart';
import 'package:weatherapp/common/get_weather_state_image.dart';
import 'package:weatherapp/common/is_day_or_night.dart';
import 'package:weatherapp/constants/gaps.dart';
import 'package:weatherapp/statemanagement_layer/catch_current_date/catch_date_time_provider.dart';
import 'package:weatherapp/statemanagement_layer/settings_state/temp_convertor_provider.dart';

class WeatherStateWidget extends StatefulWidget {
  const WeatherStateWidget({
    super.key,
    required this.main,
    required this.description,
    required this.maxTemp,
    required this.minTemp,
    required this.tempreture,
    required this.code,
    required this.sunrise,
    required this.sunset,
    this.isSearching = false,
    this.cityDate,
  });

  final double tempreture;
  final double maxTemp;
  final double minTemp;
  final String main;
  final String description;
  final int code;
  final int sunrise;
  final int sunset;

  final bool isSearching;
  final int? cityDate;

  @override
  State<WeatherStateWidget> createState() => _WeatherStateWidgetState();
}

class _WeatherStateWidgetState extends State<WeatherStateWidget> {
  bool showIndecator = false;

  void _upateIndecator() {
    setState(() => showIndecator = !showIndecator);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          "${widget.main} (${widget.description})",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gaps(hRatio: 0.02),
        SizedBox(
          width: context.screenWidth * .5,
          height: context.screenHeight * .15,
          child: SvgPicture.asset(
            weatherStateImage(
              code: widget.code,
              isDay: isDay(sunrise: widget.sunrise, sunset: widget.sunset),
            ),
            fit: BoxFit.contain,
          ),
        ),
        Text(
          "${widget.tempreture.celsiusConvertor.tempConvertor} $currentTempUnite",
          style: const TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
        /* Text(
              "Max: ${widget.maxTemp.toInt().tempConvertor} $currentTempUnite | Min: ${widget.minTemp.toInt().tempConvertor} $currentTempUnite",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ), */
        if (widget.isSearching) ...{
          Text(
            widget.cityDate!.formateTimeTemps
                .formatedDate(format: "EEEE MMMM, d"),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          )
        } else ...{
          /* Text("${currentData.formatedDate} | $currentTimeFormated") */
          StreamBuilder(
            stream: Stream.periodic(const Duration(seconds: 1), (_) {
              _upateIndecator();
            }),
            builder: (context, snapshot) {
              return Text.rich(
                TextSpan(
                  children: <InlineSpan>[
                    TextSpan(
                      text: CurrentDateTime.formatedDate,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const TextSpan(text: " | "),
                    TextSpan(
                      text: DateFormat("hh").format(DateTime.now()),
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ":",
                      style: TextStyle(
                        color: showIndecator ? Colors.purple : Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    TextSpan(
                      text: DateFormat("mm aa").format(DateTime.now()),
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        },
      ],
    );
  }
}
