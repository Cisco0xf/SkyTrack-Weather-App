import 'package:intl/intl.dart';

class CurrentDateTime {
  static final DateTime currentDate = DateTime.now();

  static String get formatedDate {
    const String foramt = "EEEE, d MMMM yyyy";
    final String formatedDate = DateFormat(foramt).format(currentDate);

    return formatedDate;
  }
}
