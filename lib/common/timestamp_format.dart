
import 'package:weatherapp/common/time_format.dart';

extension ForamtTimesTamp on int {
  String get foramtTimesTampt {
    int timesTampsMs = this * 1000;

    String formatedTime = DateTime.fromMillisecondsSinceEpoch(timesTampsMs).formatTime;

    return formatedTime;
  }
}
