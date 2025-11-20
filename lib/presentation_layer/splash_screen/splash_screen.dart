import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/common/app_dimension.dart';
import 'package:weatherapp/common/navigator_key.dart';
import 'package:weatherapp/constants/assets.dart';
import 'package:weatherapp/presentation_layer/main_screen/main_screen.dart';
import 'package:weatherapp/statemanagement_layer/settings_state/change_theme_provider.dart';
import 'package:weatherapp/statemanagement_layer/settings_state/save_last_settings/save_temp_unite.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _pushToMainScreen() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.of(navigationKey.currentContext!).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return const MainScreen();
            },
          ),
        );
      },
    );
  }

  @override
  initState() {
    _pushToMainScreen();

    InitializeCashing.initCahsing();

    final ChangeThemeProvider theme = Provider.of<ChangeThemeProvider>(
      context,
      listen: false,
    );
    theme.initialThemeData;
    theme.setColors;
    // theme.setTheme;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F1D47),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TweenAnimationBuilder(
              duration: const Duration(milliseconds: 400),
              tween: Tween<double>(begin: 0.5, end: 1.0),
              builder: (context, value, __) {
                return Transform.scale(
                  scale: value,
                  child: Opacity(
                    opacity: value,
                    child: SizedBox(
                      width: context.screenWidth * .8,
                      height: context.screenHeight * .4,
                      child: Image.asset(Assets.logo),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              width: context.screenWidth * .5,
              height: context.screenHeight * .1,
              child: Lottie.asset(Assets.loading2),
            ),
            const Text(
              "SkyTrack",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
