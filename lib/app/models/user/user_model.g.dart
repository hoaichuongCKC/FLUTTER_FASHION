// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      id: json['id'] as int,
      username: json['username'] as String,
      fullName: json['fullName'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      imageId: json['imageId'] as int,
      role: json['role'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      image: Image.fromJson(json['image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'fullName': instance.fullName,
      'phone': instance.phone,
      'email': instance.email,
      'imageId': instance.imageId,
      'role': instance.role,
      'createdAt': instance.createdAt.toIso8601String(),
      'image': instance.image.toJson(),
    };
