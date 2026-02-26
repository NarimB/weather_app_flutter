// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ForecastModel _$ForecastModelFromJson(Map<String, dynamic> json) =>
    _ForecastModel(
      date: _readDate(json, 'date') as String,
      temperature: (_readTemperature(json, 'temperature') as num).toDouble(),
      icon: _readIcon(json, 'icon') as String,
    );

Map<String, dynamic> _$ForecastModelToJson(_ForecastModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'temperature': instance.temperature,
      'icon': instance.icon,
    };
