import 'package:freezed_annotation/freezed_annotation.dart';
part 'address.freezed.dart';
part 'address.g.dart';

@freezed
class ItemProvinceModel with _$ItemProvinceModel {
  @JsonSerializable(explicitToJson: true)
  const factory ItemProvinceModel({
    required String idProvince,
    required String name,
  }) = _ItemProvinceModel;

  factory ItemProvinceModel.fromJson(Map<String, dynamic> json) =>
      _$ItemProvinceModelFromJson(json);

  static List<ItemProvinceModel> listFromJson(List data) =>
      data.map((e) => ItemProvinceModel.fromJson(e)).toList();
}

@freezed
class ItemDistrictModel with _$ItemDistrictModel {
  @JsonSerializable(explicitToJson: true)
  const factory ItemDistrictModel({
    required String idProvince,
    required String idDistrict,
    required String name,
  }) = _ItemDistrictModel;

  factory ItemDistrictModel.fromJson(Map<String, dynamic> json) =>
      _$ItemDistrictModelFromJson(json);

  static List<ItemDistrictModel> listFromJson(List data) =>
      data.map((e) => ItemDistrictModel.fromJson(e)).toList();
}

@freezed
class ItemCommuneModel with _$ItemCommuneModel {
  @JsonSerializable(explicitToJson: true)
  const factory ItemCommuneModel({
    required String idDistrict,
    required String idCommune,
    required String name,
  }) = _ItemCommuneModel;

  factory ItemCommuneModel.fromJson(Map<String, dynamic> json) =>
      _$ItemCommuneModelFromJson(json);

  static List<ItemCommuneModel> listFromJson(List data) =>
      data.map((e) => ItemCommuneModel.fromJson(e)).toList();
}
