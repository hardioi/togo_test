// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_car.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RawCar _$RawCarFromJson(Map<String, dynamic> json) => RawCar(
      tariffs: (json['tariffs'] as List<dynamic>).map((e) => e as int).toList(),
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      gosnomer: json['gosnomer'] as String,
      id: json['id'] as int,
      model: RawModel.fromJson(json['model'] as Map<String, dynamic>),
      fuel: (json['fuel'] as num).toDouble(),
      cruisingRange: (json['cruising_range'] as num).toDouble(),
      alerting: json['alerting'] as bool,
      companyId: json['company_id'] as int,
    );

Map<String, dynamic> _$RawCarToJson(RawCar instance) => <String, dynamic>{
      'id': instance.id,
      'tariffs': instance.tariffs,
      'lat': instance.lat,
      'lon': instance.lon,
      'gosnomer': instance.gosnomer,
      'model': instance.model,
      'fuel': instance.fuel,
      'cruising_range': instance.cruisingRange,
      'alerting': instance.alerting,
      'company_id': instance.companyId,
    };
