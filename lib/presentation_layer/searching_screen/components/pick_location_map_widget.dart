import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:weatherapp/common/app_dimension.dart';
import 'package:weatherapp/common/my_logger.dart';
import 'package:weatherapp/common/show_notification.dart';
import 'package:weatherapp/presentation_layer/searching_screen/components/show_weather_data_dailog.dart';
import 'package:weatherapp/statemanagement_layer/fetch_weather_data/weather_location.dart';

class PickLocationFromMapWidget extends StatefulWidget {
  const PickLocationFromMapWidget({super.key});

  @override
  State<PickLocationFromMapWidget> createState() =>
      _PickLocationFromMapWidgetState();
}

class _PickLocationFromMapWidgetState extends State<PickLocationFromMapWidget> {
  /* late final GetUserLonLatProvider userLatLongData; */

  late final WeatherLocation location;

  double long = 0;
  double lat = 0;
  @override
  void initState() {
    /* userLatLongData = Provider.of<GetUserLonLatProvider>(
      context,
      listen: false,
    ); */

    location = Provider.of<WeatherLocation>(context, listen: false);

    long = location.userLocation!.longtude;
    lat = location.userLocation!.latitude;
    Log.log("Init Lon => $long | Init Lat => $lat");

    /* long = userLatLongData.userLog;
    lat = userLatLongData.userLat; */
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(
                  long,
                  lat,
                ),
                onTap: (tapPosition, LatLng point) async {
                  log("Longtude of the tap : ${point.longitude}");
                  log("Latitude of the tap : ${point.latitude}");

                  // Convert longtude && latitude to Address

                  List<Placemark> pickedLocation =
                      await placemarkFromCoordinates(
                    point.latitude,
                    point.longitude,
                  );

                  final Placemark locationMark = pickedLocation[0];
                  final String locationCityName =
                      locationMark.locality as String;

                  log("User picked ; $locationCityName as City");
                  if (locationCityName.isEmpty) {
                    showToastification(
                      textSize: 14,
                      title: "Invalid point,please pick another",
                      type: ToastificationType.info,
                      showProgressBar: false,
                    );
                    return;
                  }
                  showWeatherDataDialog(
                    cityName: locationCityName,
                  );
                },
              ),
              children: <Widget>[
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                ),
                const MarkerLayer(
                  markers: <Marker>[
                    /*  Marker(
                      point: LatLng(lat, long), // lat : 31.100630667506266, long : 30.314015948256674
                      child: const Icon(
                        Icons.location_on,
                        size: 50,
                        color: AppColorsLightMode.subColor,
                      ),
                    ), */
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 10,
            top: context.screenHeight * .05,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.black45.withOpacity(0.4),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
