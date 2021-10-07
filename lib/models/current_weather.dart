import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class CurrentWeather extends Equatable {
  final int sunrise;
  final int sunset;
  final int humidity;
  final int timeZone;
  final String description;
  final String iconCode;
  final String cityName;
  final double windSpeed;
  final double temperature;
  final double maxTemperature;
  final double minTemperature;

  const CurrentWeather({
    @required this.sunrise,
    @required this.sunset,
    @required this.humidity,
    @required this.timeZone,
    @required this.description,
    @required this.iconCode,
    @required this.cityName,
    @required this.windSpeed,
    @required this.temperature,
    @required this.maxTemperature,
    @required this.minTemperature,
  });

  @override
  List<Object> get props => [
        sunrise,
        sunset,
        humidity,
        timeZone,
        description,
        iconCode,
        cityName,
        windSpeed,
        temperature,
        maxTemperature,
        minTemperature,
      ];

  factory CurrentWeather.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    final weather = map['weather'][0];
    return CurrentWeather(
      description: weather['description'] ?? '',
      iconCode: weather['icon'] ?? '',
      cityName: map['name'] ?? '',
      temperature: map['main']['temp'] ?? '',
      maxTemperature: map['main']['temp_max'] ?? '',
      minTemperature: map['main']['temp_min'] ?? '',
      sunrise: map['sys']['sunrise'] ?? '',
      sunset: map['sys']['sunset'] ?? '',
      humidity: map['main']['humidity'] ?? '',
      timeZone: map['timezone'] ?? '',
      windSpeed: map['wind']['speed'] ?? '',
    );
  }

  IconData getIconData() {
    switch (this.iconCode) {
      case '01d':
        return WeatherIcons.day_sunny;
      case '01n':
        return WeatherIcons.night_clear;
      case '02d':
        return WeatherIcons.day_cloudy;
      case '02n':
        return WeatherIcons.night_cloudy;
      case '03d':
      case '03n':
      case '04d':
        return WeatherIcons.day_cloudy;
      case '04n':
        return WeatherIcons.night_clear;
      case '09d':
        return WeatherIcons.day_showers;
      case '09n':
        return WeatherIcons.night_showers;
      case '10d':
        return WeatherIcons.day_rain;
      case '10n':
        return WeatherIcons.night_rain;
      case '11d':
        return WeatherIcons.day_thunderstorm;
      case '11n':
        return WeatherIcons.night_thunderstorm;
      case '13d':
        return WeatherIcons.day_snow;
      case '13n':
        return WeatherIcons.night_snow;
      case '50d':
        return WeatherIcons.day_fog;
      case '50n':
        return WeatherIcons.night_fog;
      default:
        return WeatherIcons.day_sunny;
    }
  }
}

Future<CurrentWeather> fetchCurrentWeather(String cityName) async {
  String url = "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=9ad608fb1f1cba7a243f1ef51c62ad46";
  http.Response response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return CurrentWeather.fromMap(jsonDecode(response.body));
  } else {
    Fluttertoast.showToast(msg: "Failed to load weather");
    return fetchCurrentWeather("london");
  }
}
