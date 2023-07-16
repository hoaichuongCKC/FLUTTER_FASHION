// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
part 'notification_model.g.dart';
part 'notification_model.freezed.dart';

@freezed
class NotificationModel with _$NotificationModel {
  @JsonSerializable(explicitToJson: true)
  const factory NotificationModel({
    required int id,
    int? order_id,
    required String title,
    required String subtitle,
    int? is_read,
    required DateTime updated_at,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  static List<NotificationModel> notiModelFromJson(List str) =>
      List<NotificationModel>.from(
          str.map((x) => NotificationModel.fromJson(x)));
}
