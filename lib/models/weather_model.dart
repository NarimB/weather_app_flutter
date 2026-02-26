// class WeatherModel {
//   final String cityName;
//   final double temperature;
//   final String description;
//   final String icon;
//   final int humidity;
//   final double windSpeed;

//   WeatherModel({
//     required this.cityName,
//     required this.temperature,
//     required this.description,
//     required this.icon,
//     required this.humidity,
//     required this.windSpeed,
//   });

//   factory WeatherModel.fromJson(Map<String, dynamic> json) {
//     return WeatherModel(
//       cityName: json['name'],
//       temperature: (json['main']['temp'] as num).toDouble(),
//       description: json['weather'][0]['description'],
//       icon: json['weather'][0]['icon'],
//       humidity: json['main']['humidity'],
//       windSpeed: (json['wind']['speed'] as num).toDouble(),
//     );
//   }

//   WeatherModel copyWith({double? temperature}) {
//     return WeatherModel(
//       cityName: cityName,
//       temperature: temperature ?? this.temperature,
//       description: description,
//       icon: icon,
//       humidity: humidity,
//       windSpeed: windSpeed,
//     );
//   }

//   @override
//   bool operator ==(Object other) {
//     return other is WeatherModel &&
//         other.cityName == cityName &&
//         other.temperature == temperature;
//   }

//   @override
//   int get hashCode {
//     return Object.hash(cityName, temperature);
//   }

//   @override
//   String toString() {
//     return 'WeatherModel(cityName: $cityName, temperature: $temperature, description: $description, icon: $icon, humidity: $humidity, windSpeed: $windSpeed)';
//   }
// }

import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_model.freezed.dart';
part 'weather_model.g.dart';

@freezed
abstract class WeatherModel with _$WeatherModel {
  const WeatherModel._();

  const factory WeatherModel({
    @JsonKey(name: 'name') required String cityName,
    @JsonKey(readValue: _readTemp) required double temperature,
    @JsonKey(readValue: _readDesc) required String description,
    @JsonKey(readValue: _readIcon) required String icon,
    @JsonKey(readValue: _readHumidity) required int humidity,
    @JsonKey(readValue: _readWind) required double windSpeed,
  }) = _WeatherModel;

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
}

double _readTemp(Map json, String key) =>
    (json['main']['temp'] as num).toDouble();
String _readDesc(Map json, String key) => json['weather'][0]['description'];
String _readIcon(Map json, String key) => json['weather'][0]['icon'];
int _readHumidity(Map json, String key) => json['main']['humidity'] as int;
double _readWind(Map json, String key) =>
    (json['wind']['speed'] as num).toDouble();
