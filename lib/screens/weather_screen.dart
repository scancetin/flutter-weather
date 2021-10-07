import 'package:any_weather_app/models/scale.dart';
import 'package:any_weather_app/models/current_weather.dart';
import 'package:any_weather_app/widgets/current_infos_widget.dart';
import 'package:any_weather_app/widgets/app_bar_widget.dart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({Key key}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<CurrentWeather> futureWeather;
  TextEditingController _cityNameController;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchCurrentWeather("london");
    _cityNameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder<CurrentWeather>(
        future: futureWeather,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: AppBarWidget(
                      time: DateFormat("EEEE, d MMMM yyyy").format(DateTime.fromMillisecondsSinceEpoch((snapshot.data.sunrise + snapshot.data.timeZone) * 1000)),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: cityInfos(snapshot.data.cityName, snapshot.data.description),
                  ),
                  Expanded(
                    flex: 8,
                    child: Column(
                      children: [
                        Expanded(
                          child: currentWeather(snapshot.data.temperature, snapshot.data.getIconData()),
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
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Container();
        },
      ),
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

  Column currentWeather(double temp, IconData icon) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(icon, size: 150),
        Text(
          "${Provider.of<ScaleModel>(context).convertTemp(temp)}°",
          style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Align plusButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.only(right: 10),
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: _cityNameController,
                            decoration: InputDecoration(labelText: "Change City"),
                          ),
                          SizedBox(height: 10),
                          FloatingActionButton(
                            onPressed: () {
                              print(_cityNameController.text);
                              setState(() {
                                futureWeather = fetchCurrentWeather(_cityNameController.text.toLowerCase());
                              });
                              _cityNameController.text = "";
                            },
                            child: Icon(Icons.add),
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
