import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/common/navigator_key.dart';
import 'package:weatherapp/statemanagement_layer/settings_state/save_last_settings/save_speed_unite.dart';

class SwitchSpeedUnit extends ChangeNotifier {
  bool isKmPh = true;

  Future<void> switchSppedunit(bool unit) async {
    isKmPh = unit;

    await CasheSpeedUnite.putUnitInDatabase(unit);

    notifyListeners();
  }

  void initializeSpeedUnite(bool db) {
    isKmPh = db;
  }
}

extension SpeedConvertor on double {
  double get speedConvertor {
    final BuildContext context = navigationKey.currentContext!;

    final SwitchSpeedUnit speedConvertor = Provider.of<SwitchSpeedUnit>(
      context,
      listen: false,
    );

    if (speedConvertor.isKmPh) {
      return this;
    }

    String mPersecond = (this / 3.6).toStringAsFixed(2);
    double meterPersecond = double.parse(mPersecond);
    return meterPersecond;
  }
}

String get speedUnite {
  final BuildContext context = navigationKey.currentContext!;

  final SwitchSpeedUnit speedConvertor = Provider.of<SwitchSpeedUnit>(
    context,
    listen: false,
  );

  if (speedConvertor.isKmPh) {
    return "Km/h";
  }
  return "m/s";
}
