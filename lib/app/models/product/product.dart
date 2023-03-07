// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class ProductModel with _$ProductModel {
  const factory ProductModel({
    required int id,
    required String code,
    required String name,
    required int regular_price,
    required double? discount,
    required int? sale_price,
    required Properties properties,
    required String desc,
    required int? view,
    required int sold,
    required Category category,
    required List<ProductDetail> product_detail,
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
class ProductDetail with _$ProductDetail {
  const factory ProductDetail({
    required int id,
    required String photo,
  }) = _ProductDetail;

  factory ProductDetail.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailFromJson(json);
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
