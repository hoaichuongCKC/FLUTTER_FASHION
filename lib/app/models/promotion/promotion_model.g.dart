// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PromotionModel _$$_PromotionModelFromJson(Map<String, dynamic> json) =>
    _$_PromotionModel(
      id: json['id'] as int,
      code: json['code'] as String,
      product_id: json['product_id'] as int?,
      desc: json['desc'] as String,
      order_price_conditions:
          (json['order_price_conditions'] as num).toDouble(),
      discount_price: json['discount_price'] as int,
      limit: (json['limit'] as num).toDouble(),
      end_date: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$_PromotionModelToJson(_$_PromotionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'product_id': instance.product_id,
      'desc': instance.desc,
      'order_price_conditions': instance.order_price_conditions,
      'discount_price': instance.discount_price,
      'limit': instance.limit,
      'end_date': instance.end_date?.toIso8601String(),
      'created_at': instance.created_at?.toIso8601String(),
    };
