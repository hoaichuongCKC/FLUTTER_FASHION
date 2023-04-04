// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
part 'chat.freezed.dart';
part 'chat.g.dart';

@freezed
class ChatModel with _$ChatModel {
  @JsonSerializable(explicitToJson: true)
  const factory ChatModel({
    required int id,
    required int room_chat_id,
    required int sender_id,
    required int receiver_id,
    required String message,
    required DateTime created_at,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  static List<ChatModel> chatModelFromJson(List str) =>
      List<ChatModel>.from(str.map((x) => ChatModel.fromJson(x)));
}
