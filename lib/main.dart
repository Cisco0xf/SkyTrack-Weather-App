import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:weatherapp/common/navigator_key.dart';

import 'package:weatherapp/presentation_layer/splash_screen/splash_screen.dart';
import 'package:weatherapp/statemanagement_layer/app_providers.dart';
import 'package:weatherapp/statemanagement_layer/settings_state/change_theme_provider.dart';

Future<void> main() async {
  await dotenv.load();

  runApp(const WeatherAppRoot());
}

class WeatherAppRoot extends StatelessWidget {
  const WeatherAppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: statemanagementProviders,
      child: Consumer<ChangeThemeProvider>(
        builder: (context, theme, _) {
          return ToastificationWrapper(
            child: MaterialApp(
              home: const SplashScreen(),
              navigatorKey: navigationKey,
              locale: const Locale("en"),
              supportedLocales: const [Locale("en")],
              localizationsDelegates: const [
                GlobalCupertinoLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  brightness: theme.appBrightness,
                  seedColor: const Color(0xFF48319D),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
