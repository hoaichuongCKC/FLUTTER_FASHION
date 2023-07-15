// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_fashion/app/models/user/user_model.dart';

@JsonSerializable(explicitToJson: true)
class ReviewModel extends Equatable {
  final int id;
  final UserModel user;
  final int product_id;
  final int star;
  @Default("")
  final String content;
  @Default("")
  final DateTime created_at;
  @Default([])
  final List<String> photos;

  const ReviewModel({
    required this.id,
    required this.user,
    required this.product_id,
    required this.star,
    required this.content,
    required this.created_at,
    required this.photos,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      user: UserModel.fromJson(json['user']),
      product_id: json['product_id'],
      star: json['star'],
      content: json['content'],
      created_at: DateTime.parse(json['created_at']),
      photos: List<String>.from(jsonDecode(json['photos']) as List),
    );
  }
  toJson() => {
        'id': id,
        'user': user,
        'product_id': product_id,
        'star': star,
        'content': content,
        'created_at': created_at,
        'photos': photos,
      };

  static List<ReviewModel> fromListJson(List str) =>
      List<ReviewModel>.from(str.map((x) => ReviewModel.fromJson(x)));

  @override
  List<Object> get props {
    return [
      id,
      user,
      product_id,
      star,
      content,
      created_at,
      photos,
    ];
  }
}
