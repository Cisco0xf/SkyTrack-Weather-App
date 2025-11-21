String weatherStateImage({
  required int code,
  required bool isDay,
}) {
  String imagePath = "01d";

  const String dayPath = "assets/images/svg_images/weather_state/weather_day/";
  const String nightPath =
      "assets/images/svg_images/weather_state/weather_night/";

  if (isDay) {
    if (code >= 200 && code <= 232) {
      imagePath = "${dayPath}200d.svg";
    } else if (code >= 300 && code <= 321) {
      imagePath = "${dayPath}300d.svg";
    } else if (code >= 500 && code <= 531) {
      imagePath = "${dayPath}500d.svg";
    } else if (code >= 600 && code <= 622) {
      imagePath = "${dayPath}600d.svg";
    } else if (code >= 701 && code <= 781) {
      imagePath = "${dayPath}haze.svg";
    } else if (code == 800) {
      imagePath = "${dayPath}800d.svg";
    } else if (code == 801) {
      imagePath = "${dayPath}801d.svg";
    } else if (code == 804) {
      imagePath = "${dayPath}801d.svg";
    } else if (code == 803) {
      imagePath = "${dayPath}801d.svg";
    } else {
      imagePath = "${dayPath}800d.svg";
    }
  } else {
    if (code >= 200 && code <= 232) {
      imagePath = "${nightPath}200n.svg";
    } else if (code >= 300 && code <= 321) {
      imagePath = "${nightPath}300n.svg";
    } else if (code >= 500 && code <= 531) {
      imagePath = "${nightPath}500n.svg";
    } else if (code >= 600 && code <= 622) {
      imagePath = "${nightPath}600n.svg";
    } else if (code >= 701 && code <= 781) {
      imagePath = "${dayPath}haze.svg";
    } else if (code == 800) {
      imagePath = "${nightPath}800n.svg";
    } else if (code == 801) {
      imagePath = "${nightPath}801n.svg";
    } else if (code == 804) {
      imagePath = "${nightPath}801n.svg";
    } else if (code == 803) {
      imagePath = "${nightPath}801n.svg";
    } else {
      imagePath = "${nightPath}800n.svg";
    }
  }

  return imagePath;
}
