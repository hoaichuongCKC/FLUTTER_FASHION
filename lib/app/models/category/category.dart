// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
part 'category.freezed.dart';
part 'category.g.dart';

@freezed
class CategoryModel with _$CategoryModel {
  @JsonSerializable(explicitToJson: true)
  const factory CategoryModel({
    @Default(0) int id,
    @Default("") String name,
    @Default("") String name_vi,
    @Default("") String photo,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  static List<CategoryModel> fromListJson(List<dynamic> listJson) =>
      List<dynamic>.from(listJson)
          .map((json) => CategoryModel.fromJson(json))
          .toList();
}
