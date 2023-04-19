import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/app/blocs/user/user_cubit.dart';
import 'package:flutter_fashion/app/models/chat/chat.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/app/repositories/user_repository.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final UserRepositoryImpl _userRepositoryImpl;
  ChatCubit({required UserRepositoryImpl userRepo})
      : _userRepositoryImpl = userRepo,
        super(const ChatState());

  void fetchChats() async {
    emit(state.copyWith(status: AppStatus.loading));

    final result = await _userRepositoryImpl.fetchChats();

    result.fold(
      (error) => emit(state.copyWith(status: AppStatus.error)),
      (listChat) {
        if (listChat.isEmpty) {
          emit(state.copyWith(chats: listChat, status: AppStatus.success));
        } else {
          emit(
            state.copyWith(
                roomChatId: listChat[0].room_chat_id,
                chats: listChat,
                status: AppStatus.success),
          );
        }
      },
    );
  }

  void addChat(ChatModel chat) {
    final state = this.state;
    final updateList = [...state.chats, chat];

    emit(state.copyWith(chats: updateList));
  }

  void createChat(String message) async {
    final userId = getIt.get<UserCubit>().user.id;
    final chat = ChatModel(
        id: -1,
        room_chat_id: -1,
        sender_id: userId,
        receiver_id: -1,
        message: message,
        created_at: DateTime.now());
    final updatedChats = [...state.chats, chat];
    emit(state.copyWith(
        chats: updatedChats, submitStatus: SubmitChatStatus.sending));

    final result = await _userRepositoryImpl.createChat(message: message);

    result.fold(
      (error) {
        AppSnackbarMessenger.showMessage(
            content: error, background: lightColor);
        final update = List<ChatModel>.from(state.chats)..removeLast();
        emit(state.copyWith(
            chats: update, submitStatus: SubmitChatStatus.failure));
      },
      (chatReponse) {
        final update = List<ChatModel>.from(state.chats).map((item) {
          if (item.id == chat.id) {
            return item.copyWith(
              id: chatReponse.id,
              room_chat_id: chatReponse.room_chat_id,
              sender_id: chatReponse.sender_id,
              receiver_id: chatReponse.receiver_id,
              message: message,
              created_at: chatReponse.created_at,
            );
          }
          return item;
        }).toList();

        emit(state.copyWith(
            chats: update, submitStatus: SubmitChatStatus.successfully));
      },
    );
  }
}
