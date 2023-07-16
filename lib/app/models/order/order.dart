// ignore_for_file: non_constant_identifier_names

import 'package:flutter_fashion/app/models/cart/cart.dart';
import 'package:flutter_fashion/app/models/promotion/promotion_model.dart';
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
    int? temp_price,
    int? total_price,
    PromotionModel? promotion,
    String? notes,
    int? status_id,
    DateTime? updated_at,
    List<CartModel>? order_detail,
    bool? evaluated,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  static List<OrderModel> orderListFromJson(List str) =>
      List<OrderModel>.from(str.map((x) => OrderModel.fromJson(x)));
}
