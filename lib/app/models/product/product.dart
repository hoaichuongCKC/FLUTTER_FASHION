// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';
part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class ProductModel with _$ProductModel {
  @JsonSerializable(explicitToJson: true)
  const factory ProductModel({
    int? id,
    String? SKU,
    String? name,
    int? regular_price,
    double? discount,
    int? sale_price,
    String? desc,
    int? view,
    double? star,
    int? sold,
    bool? is_popular,
    Category? category,
    List<ProductDetailModel>? product_detail,
    DateTime? created_at,
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
class ProductDetailModel with _$ProductDetailModel {
  const factory ProductDetailModel({
    required int id,
    required String photo,
    String? color,
    int? stock,
    String? size,
  }) = _ProductDetailModel;

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailModelFromJson(json);
}
