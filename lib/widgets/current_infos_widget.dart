import 'package:any_weather_app/models/scale.dart';
import 'package:any_weather_app/models/current_weather.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CurrentInfosWidget extends StatelessWidget {
  final CurrentWeather weather;
  const CurrentInfosWidget({Key key, this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              valueTile("max", Provider.of<ScaleModel>(context).convertTemp(weather.maxTemperature)),
              tilePaddingH(),
              valueTile("min", Provider.of<ScaleModel>(context).convertTemp(weather.minTemperature)),
            ],
          ),
          tilePaddingV(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              valueTile("wind", weather.windSpeed.toString()),
              tilePaddingH(),
              valueTile("hum", weather.humidity.toString()),
            ],
          ),
          tilePaddingV(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              valueTile("sunrise", DateFormat("h:mm a").format(DateTime.fromMillisecondsSinceEpoch((weather.sunrise + weather.timeZone) * 1000))),
              tilePaddingH(),
              valueTile("sunset", DateFormat("h:mm a").format(DateTime.fromMillisecondsSinceEpoch((weather.sunset + weather.timeZone) * 1000))),
            ],
          ),
        ],
      ),
    );
  }

  Column valueTile(String info, String rate) {
    return Column(
      children: [
        Text(info),
        Text(rate),
      ],
    );
  }

  Padding tilePaddingV() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 1,
        width: 105,
        color: Colors.grey,
      ),
    );
  }

  Padding tilePaddingH() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 30,
        width: 1,
        color: Colors.grey,
      ),
    );
  }
}
