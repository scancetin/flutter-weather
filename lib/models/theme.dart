import 'package:flutter/material.dart';

class CustomThemeModel extends ChangeNotifier {
  ThemeData _themeData;

  ThemeData get getThemeData => _themeData;

  void setThemeData(ThemeData data) {
    _themeData = data;
    notifyListeners();
  }
}
