// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:freezed_annotation/freezed_annotation.dart';

part 'plant_model.freezed.dart';

@freezed
class PlantModel with _$PlantModel{
  const factory PlantModel({
    required String imageName,
    required String name,
    required String descr,
    required String shortDescr,
    required double price,
    required ({double min, double max}) height,
    required ({double min, double max}) temp,
    required String pot,
    required bool favourite,
  })  = _PlantModel;
}
