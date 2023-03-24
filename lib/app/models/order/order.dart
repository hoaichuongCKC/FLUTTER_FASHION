// ignore_for_file: non_constant_identifier_names

import 'package:flutter_fashion/app/models/cart/cart.dart';
import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'order.freezed.dart';
part 'order.g.dart';

@freezed
class OrderModel with _$OrderModel {
  @JsonSerializable(explicitToJson: true)
  factory OrderModel({
    int? id,
    String? code,
    String? shipping_fullname,
    String? shipping_phone,
    String? shipping_address,
    String? order_payment,
    int? total_price,
    String? notes,
    int? status,
    DateTime? created_at,
    List<CartModel>? order_detail,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  static List<OrderModel> orderModelFromJson(List str) =>
      List<OrderModel>.from(str.map((x) => OrderModel.fromJson(x)));
}
