import 'package:flutter/material.dart';

enum TempScales { celsius, fahrenheit, kelvin }

class ScaleModel extends ChangeNotifier {
  TempScales _tempScale;

  TempScales get getTempScale => _tempScale;

  String convertTemp(double temp) {
    if (getTempScale == TempScales.celsius) {
      return (temp - 273.15).toStringAsFixed(1);
    }
    if (getTempScale == TempScales.fahrenheit) {
      return (temp * (9 / 5) - 459.67).toStringAsFixed(1);
    }
    return temp.toStringAsFixed(1);
  }

  void setScale(TempScales tempScale) {
    _tempScale = tempScale;
    notifyListeners();
    // print(tempScale);
    // print(getTempScale);
  }
}
