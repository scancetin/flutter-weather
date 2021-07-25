import 'package:flutter/material.dart';

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
}

enum TempScales { celsius, fahrenheit, kelvin }
TempScales _scale = TempScales.celsius;

Align popupMenuWidget() {
  return Align(
    alignment: Alignment.centerLeft,
    child: PopupMenuButton(
      padding: EdgeInsets.all(0),
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
                  RadioListTile<TempScales>(
                    title: Text('celcius'),
                    value: TempScales.celsius,
                    groupValue: _scale,
                    onChanged: (TempScales value) {
                      setState(() {
                        _scale = value;
                        print(_scale);
                      });
                    },
                  ),
                  RadioListTile<TempScales>(
                    title: Text('fahrenheit'),
                    value: TempScales.fahrenheit,
                    groupValue: _scale,
                    onChanged: (TempScales value) {
                      setState(() {
                        _scale = value;
                        print(_scale);
                      });
                    },
                  ),
                  RadioListTile<TempScales>(
                    title: Text('kelvin'),
                    value: TempScales.kelvin,
                    groupValue: _scale,
                    onChanged: (TempScales value) {
                      setState(() {
                        _scale = value;
                        print(_scale);
                      });
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ],
    ),
  );
}
