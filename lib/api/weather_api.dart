import 'package:app_weather/models/forecast.dart';
import 'package:app_weather/models/location.dart';


/*
This hides specific weather api implementation details and
leaves our code only knowing about the functions and the models returned by the abstract class method definition
 */
abstract class WeatherApi {
  Future<Forecast> getWeather(Location location);
  Future<Location> getLocation(String city);
}