import 'package:any_weather_app/widgets/forecast_wiget.dart';
import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({Key key}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

enum PopupOptions { brightness, tempScale }

class _WeatherScreenState extends State<WeatherScreen> {
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: menuButton(),
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
                  // Spacer(),
                  Expanded(
                    child: Column(
                      children: [
                        currentValues(),
                        plusButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: ForecasetWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Column currentValues() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            valueTile("max", "20'"),
            tilePaddingH(),
            valueTile("min", "15'"),
          ],
        ),
        tilePaddingV(70.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            valueTile("wind", "00 m/s"),
            tilePaddingH(),
            valueTile("hum", "100%"),
          ],
        ),
        tilePaddingV(105.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            valueTile("sunrise", "16:19 PM"),
            tilePaddingH(),
            valueTile("sunset", "09:00 AM"),
          ],
        ),
        SizedBox(height: 25),
      ],
    );
  }

  Padding tilePaddingV(width) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 1,
        width: width,
        color: Colors.black,
      ),
    );
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

  Padding tilePaddingH() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 30,
        width: 1,
        color: Colors.black,
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

  Align plusButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }

  Align menuButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: PopupMenuButton(
        onSelected: (PopupOptions result) {
          setState(() {
            print(result);
          });
        },
        child: Icon(
          Icons.menu,
          size: 40,
        ),
        itemBuilder: (context) => <PopupMenuEntry<PopupOptions>>[
          PopupMenuItem<PopupOptions>(
            value: PopupOptions.brightness,
            child: SwitchListTile(
              title: Text("dark mode"),
              secondary: Icon(Icons.wb_sunny),
              value: _darkMode,
              onChanged: (value) {
                setState(
                  () {
                    _darkMode = value;
                    print(_darkMode);
                  },
                );
              },
            ),
          ),
          PopupMenuItem<PopupOptions>(
            value: PopupOptions.tempScale,
            child: Text("Change Temperature Scale"),
          ),
        ],
      ),
    );
  }
}
