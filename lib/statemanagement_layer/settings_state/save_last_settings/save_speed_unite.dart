import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/common/navigator_key.dart';
import 'package:weatherapp/statemanagement_layer/settings_state/save_last_settings/prefs_keys.dart';
import 'package:weatherapp/statemanagement_layer/settings_state/speed_convertor_provider.dart';

class CasheSpeedUnite {
  static Future<void> putUnitInDatabase(bool unit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool(PrefsKeys.SPEED_KEY, unit);
  }

  static Future<bool> get catchSpeedUnitFromCashe async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final bool db = prefs.getBool(PrefsKeys.SPEED_KEY) ?? true;

    return db;
  }

  static Future<void> initializeSpeedUnitFromCahs() async {
    final bool db = await catchSpeedUnitFromCashe;

    final SwitchSpeedUnit unit = Provider.of<SwitchSpeedUnit>(
      navigationKey.currentContext!,
      listen: false,
    );

    unit.initializeSpeedUnite(db);
  }
}
