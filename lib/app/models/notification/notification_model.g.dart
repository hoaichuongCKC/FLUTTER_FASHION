// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NotificationModel _$$_NotificationModelFromJson(Map<String, dynamic> json) =>
    _$_NotificationModel(
      id: json['id'] as int,
      order_id: json['order_id'] as int?,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      is_read: json['is_read'] as int?,
      updated_at: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$_NotificationModelToJson(
        _$_NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_id': instance.order_id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'is_read': instance.is_read,
      'updated_at': instance.updated_at.toIso8601String(),
    };
