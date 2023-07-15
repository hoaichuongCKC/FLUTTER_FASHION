// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CartModel _$$_CartModelFromJson(Map<String, dynamic> json) => _$_CartModel(
      product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      product_detail_id: json['product_detail_id'] as int,
      price: json['price'] as int,
      sale_price: json['sale_price'] as int?,
      quantity: json['quantity'] as int,
      color: json['color'] as String,
      size: json['size'] as String,
      photo: json['photo'] as String,
      created_at: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$_CartModelToJson(_$_CartModel instance) =>
    <String, dynamic>{
      'product': instance.product.toJson(),
      'product_detail_id': instance.product_detail_id,
      'price': instance.price,
      'sale_price': instance.sale_price,
      'quantity': instance.quantity,
      'color': instance.color,
      'size': instance.size,
      'photo': instance.photo,
      'created_at': instance.created_at.toIso8601String(),
    };
