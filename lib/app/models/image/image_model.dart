// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
part 'image_model.freezed.dart';
part 'image_model.g.dart';

@freezed
class Image with _$Image {
  @JsonSerializable(explicitToJson: true)
  const factory Image({
    required int id,
    required String url,
    required DateTime created_at,
  }) = _Image;
  factory Image.init() => Image(id: 0, url: "", created_at: DateTime.now());
  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
}
