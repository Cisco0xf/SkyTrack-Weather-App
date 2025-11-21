import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:weatherapp/statemanagement_layer/fetch_weather_data/fetch_weather_data.dart';
import 'package:weatherapp/statemanagement_layer/fetch_weather_data/weather_location.dart';
import 'package:weatherapp/statemanagement_layer/get_each_day_data/each_day_data_provider.dart';
import 'package:weatherapp/statemanagement_layer/searching_weather/fetch_searched_city_provider.dart';
import 'package:weatherapp/statemanagement_layer/select_current_content/select_current_content_provider.dart';
import 'package:weatherapp/statemanagement_layer/settings_state/change_theme_provider.dart';
import 'package:weatherapp/statemanagement_layer/settings_state/speed_convertor_provider.dart';
import 'package:weatherapp/statemanagement_layer/settings_state/temp_convertor_provider.dart';

List<SingleChildWidget> get statemanagementProviders {
  final List<SingleChildWidget> providers = <SingleChildWidget>[
    ChangeNotifierProvider(create: (context) => SearchingCityWeatherDataProvider()),
    ChangeNotifierProvider(create: (context) => SelectCurrentContentProvider()),
    ChangeNotifierProvider(create: (context) => SwitchTemUnitProvider()),
    ChangeNotifierProvider(create: (context) => FetchWeatherProvider()),
    ChangeNotifierProvider(create: (context) => ChangeThemeProvider()),
    ChangeNotifierProvider(create: (context) => EachDayDataProvider()),
    ChangeNotifierProvider(create: (context) => SwitchSpeedUnit()),
    ChangeNotifierProvider(create: (context) => WeatherLocation()),
  ];

  return providers;
}
