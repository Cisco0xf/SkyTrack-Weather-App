import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:weatherapp/common/my_logger.dart';
import 'package:weatherapp/common/navigator_key.dart';
import 'package:weatherapp/common/show_notification.dart';
import 'package:weatherapp/statemanagement_layer/fetch_weather_data/fetch_weather_data.dart';

class WeatherLocation extends ChangeNotifier {
  // Chaeck Location Permission

  Future<bool> get _isLoationPermissionGanted async {
    final PermissionStatus locationStatus = await Permission.location.status;

    final bool isGranted = locationStatus == PermissionStatus.granted;

    if (!isGranted) {
      await Permission.location.request().whenComplete(
        () async {
          await Provider.of<FetchWeatherProvider>(
            navigationKey.currentContext!,
            listen: false,
          ).updateWeatherData();
        },
      );

      if (isGranted) {
        return true;
      }
    }

    if (isGranted) {
      return true;
    }

    return false;
  }

  // Check Location sevice is on | off

  Future<bool> get _isLocationServiceEnabled async {
    final bool isOn = await Geolocator.isLocationServiceEnabled();

    return isOn;
  }

  // Get log and lat for the API query

  double longitude = 0.0;
  double latitude = 0.0;

  Future<void> catchUserLongLat() async {
    final bool enabledLocation = await _isLocationServiceEnabled;
    final bool hasPermission = await _isLoationPermissionGanted;

    if (!enabledLocation) {
      showToastification(
        title: "Please Enable Location Service to catch the weather data",
        type: ToastificationType.warning,
        showProgressBar: false,
      );
      return;
    }

    if (!hasPermission) {
      showToastification(
        title: "Please allow the location permission to get the weather data",
        type: ToastificationType.warning,
        showProgressBar: false,
      );

      return;
    }
    final Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    longitude = position.longitude;
    latitude = position.latitude;

    Log.log("Got Longitude & latitude...");
  }

  // Get the Acual Location

  UserLocation? userLocation;

  Future<void> getUserLocation() async {
    await catchUserLongLat();

    final bool isGood = longitude != 0.0 && latitude != 0.0;

    if (!isGood) {
      log("Error in long and latitude...");
      return;
    }

    await setLocaleIdentifier("en");

    final List<Placemark> location =
        await placemarkFromCoordinates(latitude, longitude);

    final Placemark target = location[0];

    userLocation = UserLocation(
      subAdmin: target.subAdministrativeArea!,
      adminArea: target.administrativeArea!,
      locality: target.locality!,
      country: target.country!,
      longtude: longitude,
      latitude: latitude,
    );

    log("User Lon => ${userLocation!.longtude}");
    log("User Lat => ${userLocation!.latitude}");
    log("User locality => ${userLocation!.locality}");
    log("User AdminArea => ${userLocation!.adminArea}");
    log("User SubAdminArea => ${userLocation!.subAdmin}");

    notifyListeners();
  }
}

class UserLocation {
  final String country;
  final String locality;
  final String adminArea;
  final String subAdmin;

  final String uiLocation;

  final double longtude;
  final double latitude;

  const UserLocation({
    required this.adminArea,
    required this.country,
    required this.locality,
    required this.subAdmin,
    required this.latitude,
    required this.longtude,
  }) : uiLocation = "$country, $adminArea, $subAdmin";
}
