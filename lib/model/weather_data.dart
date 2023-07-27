import 'package:weatherapp_starter_project/model/weather_data_current.dart';
import 'package:weatherapp_starter_project/model/weather_data_hourly.dart';

class WeatherData {
  final WeatherDataCurrent? current;
  final WeatherDataHourly? hourly;

  WeatherData({this.current, this.hourly});

  WeatherDataCurrent getcurrentWeather() => current!;
  WeatherDataHourly getHourlyWeather() => hourly!;
}
