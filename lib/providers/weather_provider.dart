import 'package:castle_weather/models/forecast_model.dart';
import 'package:castle_weather/models/weather_model.dart';
import 'package:castle_weather/services/weather_service.dart';
import 'package:flutter/foundation.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherService _service = WeatherService();

  WeatherModel? weather;
  bool isLoading = false;
  String? error;
  List<ForecastModel> forecast = [];

  Future<void> fetchWeather(String city) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      weather = await _service.fetchWeather(city);
      forecast = await _service.fetchForecast(city);

      print('TO STRING');
      print(weather.toString());

      WeatherModel weather1 = WeatherModel(
        cityName: 'Test City',
        temperature: 25.0,
        description: 'Clear sky',
        icon: '01d',
        humidity: 60,
        windSpeed: 5.0,
      );

      WeatherModel weather2 = WeatherModel(
        cityName: 'Test City',
        temperature: 25.0,
        description: 'Clear sky',
        icon: '01d',
        humidity: 60,
        windSpeed: 5.0,
      );

      WeatherModel weatherCopy = weather2.copyWith(temperature: 30.0);
      print('COPY WITH: $weatherCopy');
      print(weatherCopy.toString());

      print(weather1 == weather2);

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      error = 'Город не найден';
      notifyListeners();
    }
  }
}
