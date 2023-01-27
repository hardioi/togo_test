import 'package:json_annotation/json_annotation.dart';

part 'raw_model.g.dart';

@JsonSerializable()
class RawModel {
  const RawModel({
    required this.id,
    required this.brand,
    required this.model,
  });

  final int id;
  final String brand;
  final String model;

  factory RawModel.fromJson(Map<String, dynamic> json) =>
      _$RawModelFromJson(json);
}
