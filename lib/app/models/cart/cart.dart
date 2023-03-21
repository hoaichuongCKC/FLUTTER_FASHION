import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'cart.freezed.dart';
part 'cart.g.dart';

@freezed
class CartModel with _$CartModel {
  @JsonSerializable(explicitToJson: true)
  const factory CartModel({
    required ProductModel product,
    required int quantity,
    required String color,
    required String size,
  }) = _CartModel;

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);

  static List<CartModel> cartModelFromJson(List str) =>
      List<CartModel>.from(str.map((x) => CartModel.fromJson(x)));
}
