import 'package:any_weather_app/screens/weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/scale.dart';
import 'models/theme.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CustomThemeModel()),
          ChangeNotifierProvider(create: (context) => ScaleModel()),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AnyWeather',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<CustomThemeModel>(context).getThemeData,
      home: WeatherScreen(),
    );
  }
}
