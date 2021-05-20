import 'dart:convert';
import 'package:app_weather/api/weather_api.dart';
import 'package:app_weather/models/forecast.dart';
import 'package:app_weather/models/location.dart';
import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;

class OpenWeatherMapWeatherApi extends WeatherApi {
  static const endPointUrl = 'https://api.openweathermap.org/data/2.5';
  static const apiKey = "a6d25705d6014a61bd3c724443acc092";
  var dio = new Dio();
  OpenWeatherMapWeatherApi();

  Future<Location> getLocation(String city) async {
    final requestUrl = '$endPointUrl/weather?q=$city&APPID=$apiKey';
    final response = await dio.get(Uri.encodeFull(requestUrl));

    if (response.statusCode != 200) {
      throw Exception(
          'error retrieving location for city $city: ${response.statusCode}');
    }

    return Location.fromJson(jsonDecode(response.toString()));
  }

  @override
  Future<Forecast> getWeather(Location location) async {
    final requestUrl =
        '$endPointUrl/onecall?lat=${location.latitude}&lon=${location.longitude}&exclude=hourly,minutely&APPID=$apiKey';
    final response = await dio.get(Uri.encodeFull(requestUrl));
    print(response.data.toString());

    if (response.statusCode != 200) {
      throw Exception('error retrieving weather: ${response.statusCode}');
    }

    return Forecast.fromJson(jsonDecode(response.toString()));
  }
}
