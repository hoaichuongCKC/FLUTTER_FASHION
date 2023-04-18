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

  final SubmitChatStatus submitStatus;
  final AppStatus status;
  const ChatState({
    this.chats = const [],
    this.status = AppStatus.init,
    this.submitStatus = SubmitChatStatus.init,
  });

  @override
  List<Object> get props => [chats, status, submitStatus];

  ChatState copyWith({
    List<ChatModel>? chats,
    int? roomChatId,
    SubmitChatStatus? submitStatus,
    AppStatus? status,
  }) {
    return ChatState(
      chats: chats ?? this.chats,
      submitStatus: submitStatus ?? this.submitStatus,
      status: status ?? this.status,
    );
  }
}
