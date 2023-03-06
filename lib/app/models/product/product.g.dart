// GENERATED CODE - DO NOT MODIFY BY HAND

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
      sale_price: json['sale_price'] as int?,
      properties:
          Properties.fromJson(json['properties'] as Map<String, dynamic>),
      desc: json['desc'] as String,
      view: json['view'] as int?,
      sold: json['sold'] as int,
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      product_detail: (json['product_detail'] as List<dynamic>)
          .map((e) => ProductDetail.fromJson(e as Map<String, dynamic>))
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
      'properties': instance.properties,
      'desc': instance.desc,
      'view': instance.view,
      'sold': instance.sold,
      'category': instance.category,
      'product_detail': instance.product_detail,
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

_$_ProductDetail _$$_ProductDetailFromJson(Map<String, dynamic> json) =>
    _$_ProductDetail(
      id: json['id'] as int,
      photo: json['photo'] as String,
    );

Map<String, dynamic> _$$_ProductDetailToJson(_$_ProductDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
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
