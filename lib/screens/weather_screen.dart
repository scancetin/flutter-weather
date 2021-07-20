import 'package:any_weather_app/widgets/current_infos_widget.dart';
import 'package:any_weather_app/widgets/forecast_widget.dart';
import 'package:any_weather_app/widgets/popup_menu_widget.dart';
import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({Key key}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

// enum PopupOptions { brightness, tempScale }
// enum TempScales { celsius, fahrenheit, kelvin }
// TempScales _scale = TempScales.celsius;

class _WeatherScreenState extends State<WeatherScreen> {
  // bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: PopupMenuWidget(),
            ),
            Expanded(
              flex: 2,
              child: cityInfos("Mountain View", "Clear Sky"),
            ),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: currentWeather("14'", Icons.wb_sunny),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        CurrentInfosWidget(),
                        plusButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: ForecastWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Column cityInfos(String city, String status) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Text(
        city,
        style: TextStyle(fontSize: 35),
      ),
      Text(
        status,
        style: TextStyle(fontSize: 25),
      ),
    ]);
  }

  Column currentWeather(String temp, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 150),
        SizedBox(height: 10),
        Text(
          "14'",
          style: TextStyle(fontSize: 60),
        ),
      ],
    );
  }

  Align plusButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
