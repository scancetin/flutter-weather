import 'package:any_weather_app/models/scale.dart';
import 'package:any_weather_app/models/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../custom_themes.dart';

class AppBarWidget extends StatefulWidget {
  final String time;
  const AppBarWidget({Key key, this.time}) : super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
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
    var scaleProvider = Provider.of<ScaleModel>(context, listen: false);

    return Align(
      alignment: Alignment.centerLeft,
      child: PopupMenuButton(
        child: Icon(Icons.menu, size: 40),
        itemBuilder: (context) => <PopupMenuEntry>[
          PopupMenuItem(
            child: Column(
              children: [
                tempScales("celcius", (value) {
                  scaleProvider.setScale(TempScales.celsius);
                }, TempScales.celsius),
                tempScales("fahrenheit", (value) {
                  scaleProvider.setScale(TempScales.fahrenheit);
                }, TempScales.fahrenheit),
                tempScales("kelvin", (value) {
                  scaleProvider.setScale(TempScales.kelvin);
                }, TempScales.kelvin),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Consumer<ScaleModel> tempScales(String scaleTitle, Function onPressed, TempScales tempScale) {
    return Consumer<ScaleModel>(builder: (context, model, child) {
      return RadioListTile<TempScales>(
        contentPadding: EdgeInsets.all(0),
        title: Text(scaleTitle),
        value: tempScale,
        groupValue: model.getTempScale,
        onChanged: onPressed,
      );
    });
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
    var themeProvider = Provider.of<CustomThemeModel>(context, listen: false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(themeProvider.isDarkMode ? Icons.brightness_2_sharp : Icons.brightness_4_sharp),
        Switch(
          activeColor: Colors.white,
          inactiveThumbColor: Colors.black,
          value: themeProvider.isDarkMode,
          onChanged: (value) {
            setState(
              () {
                if (value) {
                  themeProvider.setThemeData(darkTheme);
                } else {
                  themeProvider.setThemeData(lightTheme);
                }
              },
            );
          },
        )
      ],
    );
  }
}
