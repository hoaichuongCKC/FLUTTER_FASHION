// ignore_for_file: non_constant_identifier_names
import 'package:flutter_fashion/app/models/photo/photo.dart';
import 'package:flutter_fashion/app/models/user/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'review.freezed.dart';
part 'review.g.dart';

@freezed
class ReviewModel with _$ReviewModel {
  @JsonSerializable(explicitToJson: true)
  const factory ReviewModel({
    required int id,
    required UserModel user,
    required int star,
    required String? content,
    required DateTime? created_at,
    required List<PhotoModel>? images,
  }) = _ReviewModel;

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  static List<ReviewModel> fromListJson(List str) =>
      List<ReviewModel>.from(str.map((x) => ReviewModel.fromJson(x)));
}
