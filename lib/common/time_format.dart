extension TimeFormat on DateTime {
  String get formatTime {
    // Fotmat hours

    String hours = "";

    if (hour > 12) {
      if (hour - 12 == 10 || hour - 12 == 11 || hour - 12 == 12) {
        hours = "${hour - 12}";
      } else {
        hours = "0${hour - 12}";
      }
    } else if (hour == 0) {
      hours = "12";
    } else {
      hours = "0$hour";
    }

    // Format minuts

    String munites = "";

    if (minute < 10) {
      munites = "0$minute";
    } else {
      munites = "$minute";
    }

    // Get time Period

    String currentperiod = "";

    if (hour >= 0 && hour < 12) {
      currentperiod = "AM";
    } else {
      currentperiod = "PM";
    }

    String hoursMunitesFormat = "$hours:$munites $currentperiod";

    return hoursMunitesFormat;
  }
}
