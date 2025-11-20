import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/common/my_logger.dart';
import 'package:weatherapp/common/navigator_key.dart';
import 'package:weatherapp/statemanagement_layer/settings_state/save_last_settings/save_temp_unite.dart';

class SwitchTemUnitProvider extends ChangeNotifier {
  bool isCelsuis = false;

  Future<void> switchTempUnit(bool unit) async {
    isCelsuis = unit;

    await SaveTemUnit.putDataInDatabase(data: unit);

    Log.log("Current Temp Unit Celsuis => $isCelsuis", color: LColor.white);

    notifyListeners();
  }

  void initializetempUnitFromCahse(bool db) {
    isCelsuis = db;
  }
}

extension TempConvertor on int {
  int get tempConvertor {
    final BuildContext context = navigationKey.currentContext!;

    final SwitchTemUnitProvider tempConvertor =
        Provider.of<SwitchTemUnitProvider>(
      context,
      listen: false,
    );

    if (tempConvertor.isCelsuis) {
      return this;
    }

    double fehrenheit = (this * (9 / 5)) + 32;

    return fehrenheit.toInt();
  }
}

String get currentTempUnite {
  final BuildContext context = navigationKey.currentContext!;

  final SwitchTemUnitProvider unite = Provider.of<SwitchTemUnitProvider>(
    context,
    listen: false,
  );

  if (unite.isCelsuis) {
    return "°C";
  }

  return "°F";
}
