import 'package:any_weather_app/models/weather.dart';
import 'package:any_weather_app/widgets/current_infos_widget.dart';
import 'package:any_weather_app/widgets/forecast_widget.dart';
import 'package:any_weather_app/widgets/app_bar_widget.dart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum TempScales { celsius, fahrenheit, kelvin }
TempScales _scale = TempScales.kelvin;

class WeatherScreen extends StatefulWidget {
  final String cityName;
  WeatherScreen({Key key, this.cityName}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState(cityName: cityName);
}

class _WeatherScreenState extends State<WeatherScreen> {
  _WeatherScreenState({this.cityName});
  String cityName;
  Future<Weather> futureWeather;
  double _tempConverter = 0;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather(cityName);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Weather>(
        future: futureWeather,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Material(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Column(
                  children: [
                    Expanded(
                      child: AppBarWidget(
                        time: DateFormat("EEEE, d MMMM yyyy").format(DateTime.fromMillisecondsSinceEpoch((snapshot.data.sunrise + snapshot.data.timeZone) * 1000)),
                        radiobuttonWidget: StatefulBuilder(
                          builder: (BuildContext context, StateSetter setState) {
                            return Column(
                              children: [
                                tempScales(setState, "celcius", () {
                                  _scale = TempScales.celsius;
                                  _tempConverter = snapshot.data.temperature - 273.15;
                                  print(_tempConverter);
                                }, TempScales.celsius),
                                tempScales(setState, "fahrenheit", () {
                                  _scale = TempScales.fahrenheit;
                                  _tempConverter = snapshot.data.temperature * (9 / 5) - 459.67;
                                  print(_tempConverter);
                                }, TempScales.fahrenheit),
                                tempScales(setState, "kelvin", () {
                                  _scale = TempScales.kelvin;
                                  _tempConverter = snapshot.data.temperature;
                                  print(_tempConverter);
                                }, TempScales.kelvin),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: cityInfos(snapshot.data.cityName, snapshot.data.description),
                    ),
                    Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: currentWeather(_tempConverter.toStringAsFixed(1), snapshot.data.getIconData()),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                CurrentInfosWidget(weather: snapshot.data),
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
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Container();
        });
  }

  RadioListTile<TempScales> tempScales(StateSetter setState, String scaleTitle, Function onPressed, TempScales tempScale) {
    return RadioListTile<TempScales>(
      contentPadding: EdgeInsets.all(0),
      title: Text(scaleTitle),
      value: tempScale,
      groupValue: _scale,
      onChanged: (TempScales value) {
        setState(
          onPressed,
        );
      },
    );
  }

  Column cityInfos(String city, String status) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          city,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 50),
        ),
        Text(
          status,
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }

  Column currentWeather(String temp, IconData icon) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(icon, size: 150),
        SizedBox(height: 30),
        Text(
          "$temp°",
          style: TextStyle(fontSize: 50),
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
