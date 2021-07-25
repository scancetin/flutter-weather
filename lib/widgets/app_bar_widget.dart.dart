import 'package:flutter/material.dart';

enum TempScales { celsius, fahrenheit, kelvin }
TempScales _scale = TempScales.kelvin;

class AppBarWidget extends StatefulWidget {
  final String time;
  const AppBarWidget({Key key, this.time}) : super(key: key);

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

  Align dateTimeWidget() {
    return Align(
      alignment: Alignment.center,
      child: Text(
        widget.time,
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
                _darkMode = value;
                print(_darkMode);
              },
            );
          },
        )
      ],
    );
  }

  Align popupMenuWidget() {
    return Align(
      alignment: Alignment.centerLeft,
      child: PopupMenuButton(
        child: Icon(
          Icons.menu,
          size: 40,
        ),
        itemBuilder: (context) => <PopupMenuEntry>[
          PopupMenuItem(
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  children: [
                    tempScales(setState, "celcius", TempScales.celsius),
                    tempScales(setState, "kelvin", TempScales.fahrenheit),
                    tempScales(setState, "kelvin", TempScales.kelvin),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  RadioListTile<TempScales> tempScales(StateSetter setState, String scaleTitle, TempScales tempScale) {
    return RadioListTile<TempScales>(
      contentPadding: EdgeInsets.all(0),
      title: Text(scaleTitle),
      value: tempScale,
      groupValue: _scale,
      onChanged: (TempScales value) {
        setState(() {
          _scale = value;
          print(_scale);
        });
      },
    );
  }
}
