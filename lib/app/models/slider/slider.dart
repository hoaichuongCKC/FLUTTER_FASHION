// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
part 'slider.freezed.dart';
part 'slider.g.dart';

@freezed
class SliderModel with _$SliderModel {
  @JsonSerializable(explicitToJson: true)
  const factory SliderModel({
    @Default(0) int id,
    @Default("") String photo,
  }) = _SliderModel;

  factory SliderModel.fromJson(Map<String, dynamic> json) =>
      _$SliderModelFromJson(json);

  static List<SliderModel> fromListJson(List<dynamic> listJson) =>
      List<dynamic>.from(listJson)
          .map(
            (json) => SliderModel.fromJson(json),
          )
          .toList();
}
