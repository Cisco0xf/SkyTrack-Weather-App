import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/common/navigator_key.dart';
import 'package:weatherapp/constants/app_colors.dart';
import 'package:weatherapp/data_layer/shared_prefrences_base/sharedprefrence_main_repo.dart';
import 'package:weatherapp/statemanagement_layer/settings_state/save_last_settings/save_theme.dart';

class ColorsPalettes {
  static List<Color> firstColorsPalette = const <Color>[
    Color(0xFF134074),
    Color(0xFF006b9c),
    Color(0xFF007787),
  ];
  static List<Color> secondColorsPalette = const <Color>[
    Color(0xFF48cae4),
    Color(0xFFade8f4),
    Color(0xFFcaf0f8),
  ];
}

class ChangeThemeProvider with ChangeNotifier {
  bool isFirstTheme = true;
  bool isSecondTheme = false;
  bool isThirdTheme = false;

  List<Color> colorsPalette = const <Color>[
    Color(0xFF134074),
    Color(0xFF006b9c),
    Color(0xFF007787),
  ];

  Future<void> get setColors async {
    List<String> theme = await  themeData.getDataFromDatabase();
    bool isLight = theme[2] == "true";
    if (!isLight) {
      SwitchColors.mainColor = AppColorsDarkMode.mainColor;
      colorsPalette = ColorsPalettes.firstColorsPalette;
    } else {
      SwitchColors.mainColor = AppColorsLightMode.mainColor;
      colorsPalette = ColorsPalettes.secondColorsPalette;
    }
  }

  Brightness get appBrightness {
    Brightness brightness;
    if (isFirstTheme || isSecondTheme) {
      brightness = Brightness.dark;
    } else {
      brightness = Brightness.light;
    }

    return brightness;
  }

  final SavelastData _themeData = SaveThemeData();

  SavelastData get themeData => _themeData;

  void get setFirstTheme {
    isFirstTheme = true;
    isSecondTheme = false;
    isThirdTheme = false;
    themeData.putDataInDatabase(
      data: <String>[
        isFirstTheme.toString(),
        isSecondTheme.toString(),
        isThirdTheme.toString(),
      ],
    );

    setColors;

    notifyListeners();
  }

  void get setSecondTheme {
    isFirstTheme = false;
    isSecondTheme = true;
    isThirdTheme = false;

    themeData.putDataInDatabase(
      data: <String>[
        isFirstTheme.toString(),
        isSecondTheme.toString(),
        isThirdTheme.toString(),
      ],
    );

    setColors;

    notifyListeners();
  }

  void get setThirdTheme {
    isThirdTheme = true;
    isFirstTheme = false;
    isSecondTheme = false;
    themeData.putDataInDatabase(
      data: <String>[
        isFirstTheme.toString(),
        isSecondTheme.toString(),
        isThirdTheme.toString(),
      ],
    );

    setColors;

    notifyListeners();
  }

  Future<void> get initialThemeData async {
    List<String> theme = await themeData.getDataFromDatabase();

    isFirstTheme = theme[0] == "true";
    isSecondTheme = theme[1] == "true";
    isThirdTheme = theme[2] == "true";

    notifyListeners();
  }
}

String get mainScreenAnimatedBG {
  final BuildContext context = navigationKey.currentContext!;

  final ChangeThemeProvider theme = Provider.of<ChangeThemeProvider>(
    context,
    listen: false,
  );
  String? animationPath;

  if (theme.isFirstTheme) {
    animationPath = "assets/animations/animations/animated_bg_2.json";
  } else if (theme.isSecondTheme) {
    animationPath = "assets/animations/animations/animated_bg.json";
  } else if (theme.isThirdTheme) {
    animationPath = "assets/animations/animations/animated_bg_3.json";
  }

  return animationPath ?? "assets/animations/animations/animated_bg_2.json";
}

extension IsLight on BuildContext {
  bool get isLight {
    final ChangeThemeProvider theme = Provider.of<ChangeThemeProvider>(
      this,
      listen: false,
    );

    bool isLight = (theme.isThirdTheme);

    return isLight;
  }
}
