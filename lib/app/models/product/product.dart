// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

import '../photo/photo.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class ProductModel with _$ProductModel {
  @JsonSerializable(explicitToJson: true)
  const factory ProductModel({
    required int id,
    required String code,
    required String name,
    required int regular_price,
    required double? discount,
    @Default(0) int sale_price,
    required Properties properties,
    required String desc,
    required int? view,
    required double? star,
    required int sold,
    required bool? is_popular,
    required Category category,
    required List<PhotoModel> product_detail,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  static List<ProductModel> productModelFromJson(List str) =>
      List<ProductModel>.from(str.map((x) => ProductModel.fromJson(x)));

  static String productModelToJson(List<ProductModel> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}

@freezed
class Category with _$Category {
  const factory Category({
    required int id,
    required String name,
    required String name_vi,
    required String photo,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}

@freezed
class Properties with _$Properties {
  const factory Properties({
    List<dynamic>? sizes,
    String? origin,
    List<String>? colors,
  }) = _Properties;

  factory Properties.fromJson(Map<String, dynamic> json) =>
      _$PropertiesFromJson(json);
}
