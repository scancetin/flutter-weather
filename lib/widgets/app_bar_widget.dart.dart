import 'package:any_weather_app/models/scale.dart';
import 'package:any_weather_app/models/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    var provider = Provider.of<ScaleModel>(context, listen: false);

    return Align(
      alignment: Alignment.centerLeft,
      child: Consumer<ScaleModel>(builder: (context, model, child) {
        return PopupMenuButton(
          child: Icon(Icons.menu, size: 40),
          initialValue: 2,
          itemBuilder: (context) => <PopupMenuEntry>[
            PopupMenuItem(
              child: Column(
                children: [
                  tempScales("celcius", (value) {
                    provider.setScale(TempScales.celsius);
                    print(model.convertTemp(widget.tempKelvin));
                  }, TempScales.celsius),
                  tempScales("fahrenheit", (value) {
                    provider.setScale(TempScales.fahrenheit);
                    print(model.convertTemp(widget.tempKelvin));
                  }, TempScales.fahrenheit),
                  tempScales("kelvin", (value) {
                    provider.setScale(TempScales.kelvin);
                    print(model.convertTemp(widget.tempKelvin));
                  }, TempScales.kelvin),
                ],
              ),
            ),
          ],
        );
      }),
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
              },
            );
          },
        )
      ],
    );
  }
}
