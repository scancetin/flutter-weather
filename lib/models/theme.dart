import 'package:any_weather_app/custom_themes.dart';
import 'package:flutter/material.dart';

class CustomThemeModel extends ChangeNotifier {
  ThemeData themeData;
  bool isDarkMode;

  CustomThemeModel({
    this.isDarkMode = true,
  });

  ThemeData get getThemeData => themeData ??= darkTheme;
  bool get getDarkMode => isDarkMode;

  void setThemeData(ThemeData data) {
    isDarkMode = !isDarkMode;
    themeData = data;
    notifyListeners();
  }
}
