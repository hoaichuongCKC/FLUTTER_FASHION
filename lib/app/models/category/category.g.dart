// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CategoryModel _$$_CategoryModelFromJson(Map<String, dynamic> json) =>
    _$_CategoryModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      name_vi: json['name_vi'] as String? ?? "",
      photo: json['photo'] as String? ?? "",
      background_color: json['background_color'] as String?,
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$_CategoryModelToJson(_$_CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_vi': instance.name_vi,
      'photo': instance.photo,
      'background_color': instance.background_color,
      'created_at': instance.created_at?.toIso8601String(),
    };
