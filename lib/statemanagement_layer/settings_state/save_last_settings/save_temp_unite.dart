import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/common/navigator_key.dart';
import 'package:weatherapp/statemanagement_layer/settings_state/save_last_settings/prefs_keys.dart';
import 'package:weatherapp/statemanagement_layer/settings_state/save_last_settings/save_speed_unite.dart';
import 'package:weatherapp/statemanagement_layer/settings_state/temp_convertor_provider.dart';

class SaveTemUnit {
  const SaveTemUnit();

  static Future<void> putDataInDatabase({required bool data}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool(PrefsKeys.TEMP_UNIY_KEY, data);
  }

  static Future<bool> get catchLastTemPrefUnitFromDatabase async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final bool db = prefs.getBool(PrefsKeys.TEMP_UNIY_KEY) ?? false;

    return db;
  }

  static Future<void> initializeTemUnitCashe() async {
    final BuildContext context = navigationKey.currentContext as BuildContext;

    final SwitchTemUnitProvider switchUnit =
        Provider.of<SwitchTemUnitProvider>(context, listen: false);

    final bool db = await catchLastTemPrefUnitFromDatabase;

    switchUnit.initializetempUnitFromCahse(db);
  }
}

class InitializeCashing {
  static Future<void> initCahsing() async {
    await SaveTemUnit.initializeTemUnitCashe();

    await CasheSpeedUnite.initializeSpeedUnitFromCahs();
  }
}
