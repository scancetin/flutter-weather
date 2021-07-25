import 'package:any_weather_app/models/weather.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrentInfosWidget extends StatelessWidget {
  final Weather weather;
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
              valueTile("max", weather.maxTemperature.toString()),
              tilePaddingH(),
              valueTile("min", weather.minTemperature.toString()),
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
              valueTile("sunrise", DateFormat("h:m a").format(DateTime.fromMillisecondsSinceEpoch((weather.sunrise + weather.timeZone) * 1000))),
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
        color: Colors.black,
      ),
    );
  }

  Padding tilePaddingH() {
    print(DateFormat("h:m a").format(DateTime.fromMillisecondsSinceEpoch((weather.sunrise + weather.timeZone) * 1000)));
    print(DateFormat("h:m a").format(DateTime.fromMillisecondsSinceEpoch((weather.sunset + weather.timeZone) * 1000)));
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 30,
        width: 1,
        color: Colors.black,
      ),
    );
  }
}
