import 'package:any_weather_app/models/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum TempScales { celsius, fahrenheit, kelvin }
TempScales _scale = TempScales.kelvin;

class AppBarWidget extends StatefulWidget {
  final String time;
  final double tempKelvin;
  const AppBarWidget({Key key, this.time, this.tempKelvin}) : super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  bool _darkMode = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: popupMenuWidget()),
        Expanded(flex: 2, child: dateTimeWidget()),
        Expanded(child: switchWidget()),
      ],
    );
  }

  Align popupMenuWidget() {
    double _tempConverter = 0;
    return Align(
      alignment: Alignment.centerLeft,
      child: PopupMenuButton(
        child: Icon(Icons.menu, size: 40),
        itemBuilder: (context) => <PopupMenuEntry>[
          PopupMenuItem(
            child: Column(
              children: [
                tempScales(setState, "celcius", () {
                  _scale = TempScales.celsius;
                  _tempConverter = (widget.tempKelvin - 273.15).roundToDouble();
                  print(_tempConverter);
                }, TempScales.celsius),
                tempScales(setState, "fahrenheit", () {
                  _scale = TempScales.fahrenheit;
                  _tempConverter = (widget.tempKelvin * (9 / 5) - 459.67).roundToDouble();
                  print(_tempConverter);
                }, TempScales.fahrenheit),
                tempScales(setState, "kelvin", () {
                  _scale = TempScales.kelvin;
                  _tempConverter = widget.tempKelvin.roundToDouble();
                  print(_tempConverter);
                }, TempScales.kelvin),
              ],
            ),
          ),
        ],
      ),
    );
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

  Center dateTimeWidget() {
    return Center(
      child: Text(
        widget.time,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  Row switchWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(_darkMode ? Icons.brightness_2_sharp : Icons.brightness_4_sharp),
        Switch(
          activeColor: Colors.white,
          inactiveThumbColor: Colors.black,
          value: _darkMode,
          onChanged: (value) {
            setState(
              () {
                if (value) {
                  Provider.of<CustomThemeModel>(context, listen: false).setThemeData(ThemeData.dark());
                } else {
                  Provider.of<CustomThemeModel>(context, listen: false).setThemeData(ThemeData.light());
                }
                _darkMode = value;
                print(_darkMode);
              },
            );
          },
        )
      ],
    );
  }
}
