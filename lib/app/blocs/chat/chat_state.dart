// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'chat_cubit.dart';

enum SubmitChatStatus {
  init,
  sending,
  successfully,
  failure,
}

class ChatState extends Equatable {
  final List<ChatModel> chats;
  final int? roomChatId;
  final SubmitChatStatus submitStatus;
  final AppStatus status;
  const ChatState(
      {this.chats = const [],
      this.status = AppStatus.init,
      this.roomChatId,
      this.submitStatus = SubmitChatStatus.init});

  @override
  List<Object> get props => [chats, status, roomChatId ?? 0, submitStatus];

  ChatState copyWith({
    List<ChatModel>? chats,
    int? roomChatId,
    SubmitChatStatus? submitStatus,
    AppStatus? status,
  }) {
    return ChatState(
      chats: chats ?? this.chats,
      roomChatId: roomChatId ?? this.roomChatId,
      submitStatus: submitStatus ?? this.submitStatus,
      status: status ?? this.status,
    );
  }
}
