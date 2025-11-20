import 'package:weatherapp/data_layer/models/forcecase_models/next_forcecase_data/next_forcecase_main_data.dart';
class WeatherForcecaseDataModel {
  final String code;
  final int message;
  final int count;
  final List<NextForcecaseData> forcecaseDataList;

  WeatherForcecaseDataModel({
    required this.code,
    required this.count,
    required this.message,
    required this.forcecaseDataList,
  });

  factory WeatherForcecaseDataModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return WeatherForcecaseDataModel(
      code: json["cod"],
      count: json["cnt"],
      message: json["message"],
      forcecaseDataList: (json["list"] as List<dynamic>).map(
        (forcecase) {
          return NextForcecaseData.fromJson(
            json: forcecase,
          );
        },
      ).toList(),
    );
  }
}
