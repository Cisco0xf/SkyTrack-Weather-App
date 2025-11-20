String windDirection({
  required int degree,
}) {
  String direction = "Direction";

  if (degree == 0 || degree == 360) {
    direction = "North";
  } else if (degree == 90) {
    direction = "East ";
  } else if (degree >= 1 && degree <= 89) {
    direction = "Northeast";
  } else if (degree >= 91 && degree <= 179) {
    direction = "Southeast ";
  } else if (degree == 180) {
    direction = "South";
  } else if (degree >= 181 && degree <= 279) {
    direction = "Southwest ";
  } else if (degree == 270) {
    direction = "West";
  } else if (degree >= 271 && degree <= 379) {
    direction = "Northwest ";
  }

  return direction;
}
