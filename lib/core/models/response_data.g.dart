// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ResponseData _$$_ResponseDataFromJson(Map<String, dynamic> json) =>
    _$_ResponseData(
      status: json['status'] as bool? ?? false,
      data: json['data'],
      message: json['message'] as String? ?? "",
    );

Map<String, dynamic> _$$_ResponseDataToJson(_$_ResponseData instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
