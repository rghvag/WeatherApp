import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weatherapp_starter_project/model/weather_data.dart';
import 'package:weatherapp_starter_project/model/weather_data_current.dart';

import '../model/weather_data_hourly.dart';
import '../utils/api_url.dart';

class FetchWeatherAPI {
  WeatherData? weatherData;
  WeatherDataCurrent? weatherDataCurrent;

  //processing the data from response to json
  Future<WeatherData> processData(lat, lon) async {
    var response = await http.get(Uri.parse(apiURL(lat, lon)));
    var JsonString = jsonDecode(response.body);
    weatherData = WeatherData(current: WeatherDataCurrent.fromJson(JsonString),
    hourly: WeatherDataHourly.fromJson(JsonString),
    );
  
    return weatherData!;
  }
}

// String apiURL(var lat, var lon) {
//   String url = "";
//   url =
//       "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=metric&exclude=minutely";
//   return url;
// }
