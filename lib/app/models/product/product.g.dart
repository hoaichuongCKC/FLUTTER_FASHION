// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProductModel _$$_ProductModelFromJson(Map<String, dynamic> json) =>
    _$_ProductModel(
      id: json['id'] as int,
      code: json['code'] as String,
      name: json['name'] as String,
      regular_price: json['regular_price'] as int,
      discount: (json['discount'] as num?)?.toDouble(),
      sale_price: json['sale_price'] as int? ?? 0,
      properties:
          Properties.fromJson(json['properties'] as Map<String, dynamic>),
      desc: json['desc'] as String,
      view: json['view'] as int?,
      star: (json['star'] as num?)?.toDouble(),
      sold: json['sold'] as int,
      is_popular: json['is_popular'] as bool?,
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      product_detail: (json['product_detail'] as List<dynamic>)
          .map((e) => PhotoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ProductModelToJson(_$_ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'regular_price': instance.regular_price,
      'discount': instance.discount,
      'sale_price': instance.sale_price,
      'properties': instance.properties.toJson(),
      'desc': instance.desc,
      'view': instance.view,
      'star': instance.star,
      'sold': instance.sold,
      'is_popular': instance.is_popular,
      'category': instance.category.toJson(),
      'product_detail': instance.product_detail.map((e) => e.toJson()).toList(),
    };

_$_Category _$$_CategoryFromJson(Map<String, dynamic> json) => _$_Category(
      id: json['id'] as int,
      name: json['name'] as String,
      name_vi: json['name_vi'] as String,
      photo: json['photo'] as String,
    );

Map<String, dynamic> _$$_CategoryToJson(_$_Category instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_vi': instance.name_vi,
      'photo': instance.photo,
    };

_$_Properties _$$_PropertiesFromJson(Map<String, dynamic> json) =>
    _$_Properties(
      sizes: json['sizes'] as List<dynamic>?,
      origin: json['origin'] as String?,
      colors:
          (json['colors'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_PropertiesToJson(_$_Properties instance) =>
    <String, dynamic>{
      'sizes': instance.sizes,
      'origin': instance.origin,
      'colors': instance.colors,
    };
