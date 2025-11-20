bool isDay({
  required int sunrise,
  required int sunset,
  int? customHour,
  bool isCustom = false,
}) {
  // Sunrise Data
  int sunriseMs = sunrise * 1000;
  DateTime sunriseDate = DateTime.fromMillisecondsSinceEpoch(sunriseMs);

  int sunriseHour = sunriseDate.hour;

  int sunsetMs = sunset * 1000;
  DateTime sunsetDate = DateTime.fromMillisecondsSinceEpoch(sunsetMs);
  int sunsetHour = sunsetDate.hour;
  // Custom Data

  DateTime currentDate = DateTime.now();

  int currentHour = currentDate.hour;

  DateTime customHourFormated = DateTime.now();

  if (customHour != null) {
    customHourFormated = DateTime.fromMillisecondsSinceEpoch(customHour * 1000);
  }

  customHour = customHourFormated.hour;

  bool isDay = isCustom
      ? customHour >= sunriseHour && customHour <= sunsetHour
      : currentHour >= sunriseHour && currentHour <= sunsetHour;

  return isDay;
}
