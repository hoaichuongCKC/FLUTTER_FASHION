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

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
}
