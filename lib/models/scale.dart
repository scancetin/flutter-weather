import 'package:flutter/material.dart';

enum TempScales { celsius, fahrenheit, kelvin }

class ScaleModel extends ChangeNotifier {
  TempScales tempScale;

  ScaleModel({
    this.tempScale = TempScales.celsius,
  });

  TempScales get getTempScale => tempScale;

  String convertTemp(double temp) {
    if (getTempScale == TempScales.celsius) {
      return (temp - 273.15).toStringAsFixed(1);
    } else if (getTempScale == TempScales.fahrenheit) {
      return (temp * (9 / 5) - 459.67).toStringAsFixed(1);
    }
    return temp.toStringAsFixed(1);
  }

  void setScale(TempScales newScale) {
    tempScale = newScale;
    notifyListeners();
  }
}
