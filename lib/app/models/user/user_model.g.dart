// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      username: json['username'] as String? ?? "",
      fullName: json['fullName'] as String? ?? "",
      phone: json['phone'] as String? ?? "",
      email: json['email'] as String? ?? "",
      image: Image.fromJson(json['image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'fullName': instance.fullName,
      'phone': instance.phone,
      'email': instance.email,
      'image': instance.image.toJson(),
    };
