import 'dart:convert';

import 'package:castle_weather/models/forecast_model.dart';
import 'package:castle_weather/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String _apiKey = 'a65ca8c5430c9c149b23e1bea6f9037a';

  Future<WeatherModel> fetchWeather(String city) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_apiKey&units=metric&lang=ru',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return WeatherModel.fromJson(data);
    } else {
      throw Exception('Город не найден');
    }
  }

  Future<List<ForecastModel>> fetchForecast(String city) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$_apiKey&units=metric',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      List list = data['list'];

      List<ForecastModel> dailyForecast = [];

      for (var item in list) {
        if (item['dt_txt'].toString().contains('12:00:00')) {
          dailyForecast.add(ForecastModel.fromJson(item));
        }
      }
      return dailyForecast.take(3).toList();
    } else {
      throw Exception('Ощибка');
    }
  }
}
