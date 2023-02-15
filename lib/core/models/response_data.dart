// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:freezed_annotation/freezed_annotation.dart';
part 'response_data.freezed.dart';
part 'response_data.g.dart';

@freezed
class ResponseData with _$ResponseData {
  @JsonSerializable(explicitToJson: true)
  const factory ResponseData({
    @Default(false) bool status,
    required dynamic data,
    @Default("") String message,
  }) = _ResponseData;

  factory ResponseData.fromJson(Map<String, dynamic> json) =>
      _$ResponseDataFromJson(json);
}
