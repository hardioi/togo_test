import 'package:json_annotation/json_annotation.dart';
import 'raw_model.dart';

part 'raw_car.g.dart';

@JsonSerializable()
class RawCar {
  const RawCar({
    required this.tariffs,
    required this.lat,
    required this.lon,
    required this.gosnomer,
    required this.id,
    required this.model,
    required this.fuel,
    required this.cruisingRange,
    required this.alerting,
    required this.companyId,
  });

  final int id;
  final List<int> tariffs;
  final double lat;
  final double lon;
  final String gosnomer;
  final RawModel model;
  final double fuel;
  @JsonKey(name: 'cruising_range')
  final double cruisingRange;
  final bool alerting;
  @JsonKey(name: 'company_id')
  final int companyId;

  factory RawCar.fromJson(Map<String, dynamic> json) => _$RawCarFromJson(json);
}
