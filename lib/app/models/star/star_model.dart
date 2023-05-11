import 'package:freezed_annotation/freezed_annotation.dart';
part 'star_model.freezed.dart';
part 'star_model.g.dart';

@freezed
class StarModel with _$StarModel {
  @JsonSerializable(explicitToJson: true)
  const factory StarModel({
    required int star,
    required int count,
  }) = _StarModel;

  factory StarModel.fromJson(Map<String, dynamic> json) =>
      _$StarModelFromJson(json);
}
