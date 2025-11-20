extension CelsiusConvertor on double {
  int get celsiusConvertor {
    int celsius = (this - 273.15).toInt();

    return celsius;
  }
}
