// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OrderModel _$$_OrderModelFromJson(Map<String, dynamic> json) =>
    _$_OrderModel(
      id: json['id'] as int?,
      code: json['code'] as String?,
      shipping_fullname: json['shipping_fullname'] as String?,
      shipping_phone: json['shipping_phone'] as String?,
      shipping_address: json['shipping_address'] as String?,
      order_payment: json['order_payment'] as String?,
      total_price: json['total_price'] as int?,
      notes: json['notes'] as String?,
      status: json['status'] as int?,
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      order_detail: (json['order_detail'] as List<dynamic>?)
          ?.map((e) => CartModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      evaluated: json['evaluated'] as bool?,
    );

Map<String, dynamic> _$$_OrderModelToJson(_$_OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'shipping_fullname': instance.shipping_fullname,
      'shipping_phone': instance.shipping_phone,
      'shipping_address': instance.shipping_address,
      'order_payment': instance.order_payment,
      'total_price': instance.total_price,
      'notes': instance.notes,
      'status': instance.status,
      'created_at': instance.created_at?.toIso8601String(),
      'order_detail': instance.order_detail?.map((e) => e.toJson()).toList(),
      'evaluated': instance.evaluated,
    };
