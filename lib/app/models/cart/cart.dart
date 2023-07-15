// ignore_for_file: non_constant_identifier_names

import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'cart.freezed.dart';
part 'cart.g.dart';

@freezed
class CartModel with _$CartModel {
  @JsonSerializable(explicitToJson: true)
  const factory CartModel({
    required ProductModel product,
    required int product_detail_id,
    required int price,
    required int? sale_price,
    required int quantity,
    required String color,
    required String size,
    required String photo,
    required DateTime created_at,
  }) = _CartModel;

  factory CartModel.init(Map<String, dynamic> json) => CartModel(
        product: json["product"],
        quantity: json["quantity"],
        price: json["price"],
        product_detail_id: json["product_detail_id"],
        color: json["color"],
        sale_price: json['sale_price'],
        size: json["size"],
        photo: json["photo"],
        created_at: DateTime.now(),
      );

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);

  static List<CartModel> cartModelFromJson(List str) =>
      List<CartModel>.from(str.map((x) => CartModel.fromJson(x)));
}
