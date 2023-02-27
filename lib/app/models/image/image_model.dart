// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
part 'image_model.freezed.dart';
part 'image_model.g.dart';

@freezed
class Image with _$Image {
  @JsonSerializable(explicitToJson: true)
  const factory Image({
    @Default(0) int id,
    @Default("") String url,
  }) = _Image;
  factory Image.init() => const Image();
  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
}
