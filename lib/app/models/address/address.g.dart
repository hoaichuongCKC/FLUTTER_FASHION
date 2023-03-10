// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ItemProvinceModel _$$_ItemProvinceModelFromJson(Map<String, dynamic> json) =>
    _$_ItemProvinceModel(
      idProvince: json['idProvince'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$_ItemProvinceModelToJson(
        _$_ItemProvinceModel instance) =>
    <String, dynamic>{
      'idProvince': instance.idProvince,
      'name': instance.name,
    };

_$_ItemDistrictModel _$$_ItemDistrictModelFromJson(Map<String, dynamic> json) =>
    _$_ItemDistrictModel(
      idProvince: json['idProvince'] as String,
      idDistrict: json['idDistrict'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$_ItemDistrictModelToJson(
        _$_ItemDistrictModel instance) =>
    <String, dynamic>{
      'idProvince': instance.idProvince,
      'idDistrict': instance.idDistrict,
      'name': instance.name,
    };

_$_ItemCommuneModel _$$_ItemCommuneModelFromJson(Map<String, dynamic> json) =>
    _$_ItemCommuneModel(
      idDistrict: json['idDistrict'] as String,
      idCommune: json['idCommune'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$_ItemCommuneModelToJson(_$_ItemCommuneModel instance) =>
    <String, dynamic>{
      'idDistrict': instance.idDistrict,
      'idCommune': instance.idCommune,
      'name': instance.name,
    };
