import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/data_layer/shared_prefrences_base/sharedprefrence_main_repo.dart';

class SaveThemeData implements SavelastData {
  final String themeUnitekey = "THEME_DATA_KEY";
  @override
  Future<void> putDataInDatabase({
    required List<String> data,
  }) async {
    final SharedPreferences themeUnitePref =
        await SharedPreferences.getInstance();

    await themeUnitePref.setStringList(
      themeUnitekey,
      data,
    );
  }

  @override
  Future<List<String>> getDataFromDatabase() async {
    final SharedPreferences themeUnitePref =
        await SharedPreferences.getInstance();

    List<String> themeUniteData = themeUnitePref.getStringList(themeUnitekey) ??
        <String>[
          "true",
          "false",
          "false",
        ];
    return themeUniteData;
  }
}
