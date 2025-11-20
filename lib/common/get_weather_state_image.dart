String weatherStateImage({
  required int code,
  required bool isDay,
}) {
  String imagePath = "01d";
  if (isDay) {
    if (code >= 200 && code <= 232) {
      imagePath = "assets/images/svg_images/weather_state/weather_day/200d.svg";
    } else if (code >= 300 && code <= 321) {
      imagePath = "assets/images/svg_images/weather_state/weather_day/300d.svg";
    } else if (code >= 500 && code <= 531) {
      imagePath = "assets/images/svg_images/weather_state/weather_day/500d.svg";
    } else if (code >= 600 && code <= 622) {
      imagePath = "assets/images/svg_images/weather_state/weather_day/600d.svg";
    } else if (code >= 701 && code <= 781) {
      imagePath = "assets/images/svg_images/weather_state/weather_day/haze.svg";
    } else if (code == 800) {
      imagePath = "assets/images/svg_images/weather_state/weather_day/800d.svg";
    } else if (code == 801) {
      imagePath = "assets/images/svg_images/weather_state/weather_day/801d.svg";
    } else if (code == 804) {
      imagePath = "assets/images/svg_images/weather_state/weather_day/801d.svg";
    } else if (code == 803) {
      imagePath = "assets/images/svg_images/weather_state/weather_day/801d.svg";
    } else {
      imagePath = "assets/images/svg_images/weather_state/weather_day/800d.svg";
    }
  } else {
    if (code >= 200 && code <= 232) {
      imagePath =
          "assets/images/svg_images/weather_state/weather_night/200n.svg";
    } else if (code >= 300 && code <= 321) {
      imagePath =
          "assets/images/svg_images/weather_state/weather_night/300n.svg";
    } else if (code >= 500 && code <= 531) {
      imagePath =
          "assets/images/svg_images/weather_state/weather_night/500n.svg";
    } else if (code >= 600 && code <= 622) {
      imagePath =
          "assets/images/svg_images/weather_state/weather_night/600n.svg";
    } else if (code >= 701 && code <= 781) {
      imagePath = "assets/images/svg_images/weather_state/weather_day/haze.svg";
    } else if (code == 800) {
      imagePath =
          "assets/images/svg_images/weather_state/weather_night/800n.svg";
    } else if (code == 801) {
      imagePath =
          "assets/images/svg_images/weather_state/weather_night/801n.svg";
    } else if (code == 804) {
      imagePath =
          "assets/images/svg_images/weather_state/weather_night/801n.svg";
    } else if (code == 803) {
      imagePath =
          "assets/images/svg_images/weather_state/weather_night/801n.svg";
    } else {
      imagePath =
          "assets/images/svg_images/weather_state/weather_night/800n.svg";
    }
  }

  return imagePath;
}
