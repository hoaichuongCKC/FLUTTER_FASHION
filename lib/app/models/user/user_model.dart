// ignore_for_file: non_constant_identifier_names

import 'package:flutter_fashion/app/models/image/image_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  @JsonSerializable(explicitToJson: true)
  const factory UserModel({
    @Default("") String username,
    @Default("") String fullName,
    @Default("") String phone,
    @Default("") String email,
    required Image image,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.init() => UserModel(
        image: Image.init(),
      );
}
