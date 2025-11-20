import 'package:intl/intl.dart';

extension DateFormatEx on DateTime {
  String formatedDate({String format = "MMM, d"}) {
    String date = DateFormat(format).format(this);

    return date;
  }
}

extension ForamtTimesTampDate on int {
  DateTime get formateTimeTemps {
    int timesTempMs = this * 1000;

    DateTime formatedDate = DateTime.fromMillisecondsSinceEpoch(
      timesTempMs,
    );

    return formatedDate;
  }
}
