import 'package:freezed_annotation/freezed_annotation.dart';
part 'photo.freezed.dart';
part 'photo.g.dart';

@freezed
class PhotoModel with _$PhotoModel {
  @JsonSerializable(explicitToJson: true)
  const factory PhotoModel({
    required int id,
    required String photo,
  }) = _PhotoModel;

  factory PhotoModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoModelFromJson(json);
}
