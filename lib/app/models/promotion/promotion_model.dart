// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
part 'promotion_model.g.dart';
part 'promotion_model.freezed.dart';

@freezed
class PromotionModel with _$PromotionModel {
  @JsonSerializable(explicitToJson: true)
  const factory PromotionModel({
    required int id,
    required String name,
    required String code,
    int? product_id,
    required String desc,
    required double order_price_conditions,
    required int discount_price,
    required double limit,
    DateTime? end_date,
    DateTime? created_at,
  }) = _PromotionModel;

  factory PromotionModel.fromJson(Map<String, dynamic> json) =>
      _$PromotionModelFromJson(json);

  static List<PromotionModel> promotionModelFromJson(List str) =>
      List<PromotionModel>.from(str.map((x) => PromotionModel.fromJson(x)));
}
