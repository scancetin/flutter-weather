import 'package:flutter/material.dart';

class PopupMenuWidget extends StatefulWidget {
  PopupMenuWidget({Key key}) : super(key: key);

  @override
  _PopupMenuWidgetState createState() => _PopupMenuWidgetState();
}

enum PopupOptions { brightness, tempScale }
enum TempScales { celsius, fahrenheit, kelvin }
TempScales _scale = TempScales.celsius;
bool _darkMode = false;

class _PopupMenuWidgetState extends State<PopupMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: PopupMenuButton(
        child: Icon(
          Icons.menu,
          size: 40,
        ),
        itemBuilder: (context) => <PopupMenuEntry<PopupOptions>>[
          PopupMenuItem<PopupOptions>(
            value: PopupOptions.brightness,
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return SwitchListTile(
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
                );
              },
            ),
          ),
          PopupMenuItem<PopupOptions>(
            value: PopupOptions.tempScale,
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  children: [
                    RadioListTile<TempScales>(
                      title: Text('celcius'),
                      contentPadding: EdgeInsets.all(5),
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
                      contentPadding: EdgeInsets.all(5),
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
                      contentPadding: EdgeInsets.all(3),
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
}
