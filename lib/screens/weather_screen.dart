import 'package:any_weather_app/models/weather.dart';
import 'package:any_weather_app/widgets/current_infos_widget.dart';
import 'package:any_weather_app/widgets/forecast_widget.dart';
import 'package:any_weather_app/widgets/app_bar_widget.dart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: cityInfos(snapshot.data.cityName, snapshot.data.description, snapshot.data),
                    ),
                    Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: currentWeather(snapshot.data.temperature.toString(), snapshot.data.getIconData()),
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

  Column cityInfos(String city, String status, Weather data) {
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
          temp,
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
