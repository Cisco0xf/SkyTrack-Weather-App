# SkyTrack - Weather App

***Full Functional Weather App Built With FLutter and Provider***

## How to Install:

> [!NOTE]
> In the `pubspec.yamle` fie you will find the `.env` file in the assets, you will have to create one
> 
> Flutter version of the project : `v3.24.2`

1- Got to [OpenWeatherMap](https://openweathermap.org/api/one-call-api) and create a new API Key

2- Run the command `git clone https://github.com/Cisco0xf/SkyTrack-Weather-App.git`

3- In the project directory, run `flutter clean` ,then `flutter pub get`

4- Create the `.env` file (which it already added in the assets)

5- In the `.env` file create new variable `WEATHER_API_KEY = "YOU_API_KEY"`

6- Now, the project is ready, run `flutter build apk`

## Dependency:

```yaml
dependencies:
  cupertino_icons: ^1.0.8
  fl_chart: ^0.69.0
  flutter:
    sdk: flutter
  flutter_map: ^7.0.2
  flutter_native_splash: ^2.4.1
  flutter_svg: ^2.0.10+1
  geocoding: ^3.0.0
  geolocator: ^13.0.1
  http: ^1.2.2
  intl: ^0.19.0
  latlong2: ^0.9.1
  lottie: ^3.1.2
  permission_handler: ^12.0.1
  provider: ^6.1.2
  shared_preferences: ^2.3.2
  toastification: ^2.3.0
  flutter_localizations: 
    sdk: flutter
  flutter_dotenv: ^6.0.0

```


## Features:
- Clean and well-organized code architecture

- Local database caching for weather data

- Provider state management implementation

- Modern UI/UX with smooth animations

- Weather charts using fl_chart

- Offline data fallback support

- Interactive weather maps with `flutter_map`

- Location-based weather data on map

- Multiple location support with city search

- Better API error handling and retry logic

- Unit conversion (Celsius/Fahrenheit, etc.)

- Dynamic themes and animated backgrounds

- More detailed weather metrics

## App Screens:


<table>
   <tr>
    <td align="center"><b>Main Screen</b></td>
    <td align="center"><b>Hourly Weather Data</b></td>
    <td align="center"><b>Data Visualization</b></td>
  </tr>
  
  <tr>
    <td><img src="https://github.com/Cisco0xf/knooz_documentation_api_assets/blob/main/weather_app/1.webp?raw=true" alt="Screen" width="250"/></td>
    <td><img src="https://github.com/Cisco0xf/knooz_documentation_api_assets/blob/main/weather_app/2.webp?raw=true" alt="Screen" width="250"/></td>
    <td><img src="https://github.com/Cisco0xf/knooz_documentation_api_assets/blob/main/weather_app/3.webp?raw=true" alt="Screen" width="250"/></td>
  </tr>
 
</table>

<table>
   <tr>
    <td align="center"><b>Forcast Screen</b></td>
    <td align="center"><b>Searching Screen</b></td>
    <td align="center"><b>Catch Location</b></td>
  </tr>
  
  <tr>
    <td><img src="https://github.com/Cisco0xf/knooz_documentation_api_assets/blob/main/weather_app/4.webp?raw=true" alt="Screen" width="250"/></td>
    <td><img src="https://github.com/Cisco0xf/knooz_documentation_api_assets/blob/main/weather_app/5.webp?raw=true" alt="Screen" width="250"/></td>
    <td><img src="https://github.com/Cisco0xf/knooz_documentation_api_assets/blob/main/weather_app/6.webp?raw=true" alt="Screen" width="250"/></td>
  </tr>
 
</table>

<table>
   <tr>
    <td align="center"><b>Second theme</b></td>
    <td align="center"><b>Light theme</b></td>
    <td align="center"><b>Light theme</b></td>
  </tr>
  
  <tr>
    <td><img src="https://github.com/Cisco0xf/knooz_documentation_api_assets/blob/main/weather_app/7.webp?raw=true" alt="Screen" width="250"/></td>
    <td><img src="https://github.com/Cisco0xf/knooz_documentation_api_assets/blob/main/weather_app/8.webp?raw=true" alt="Screen" width="250"/></td>
    <td><img src="https://github.com/Cisco0xf/knooz_documentation_api_assets/blob/main/weather_app/9.webp?raw=true" alt="Screen" width="250"/></td>
  </tr>
 
</table>

<table>
   <tr>
    <td align="center"><b>Init Search</b></td>
  </tr>
  
  <tr>
    <td><img src="https://github.com/Cisco0xf/knooz_documentation_api_assets/blob/main/weather_app/10.webp?raw=true" alt="Screen" width="250"/></td>
  </tr>
 
</table>

