// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_chart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ReviewsModel _$$_ReviewsModelFromJson(Map<String, dynamic> json) =>
    _$_ReviewsModel(
      length: json['length'] as int?,
      reviews: (json['reviews'] as List<dynamic>)
          .map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      star_group: (json['star_group'] as List<dynamic>?)
          ?.map((e) => StarModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ReviewsModelToJson(_$_ReviewsModel instance) =>
    <String, dynamic>{
      'length': instance.length,
      'reviews': instance.reviews.map((e) => e.toJson()).toList(),
      'star_group': instance.star_group?.map((e) => e.toJson()).toList(),
    };
