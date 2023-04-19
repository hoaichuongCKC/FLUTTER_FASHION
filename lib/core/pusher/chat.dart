import 'dart:convert';
import 'dart:developer';
import 'package:flutter_fashion/app/blocs/chat/chat_cubit.dart';
import 'package:flutter_fashion/app/blocs/user/user_cubit.dart';
import 'package:flutter_fashion/app/models/chat/chat.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/config/pusher.dart';
import 'package:flutter_fashion/core/notification/notification_service.dart';
import 'package:flutter_fashion/core/pusher/pusher_app.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherChatApp with PusherMixin implements PusherApp {
  final ApiService apiService;

  PusherChatApp({required this.apiService});
  String get currentLocation => AppRoutes.router.location;

  String get chatLocation => "${Routes.PROFILE}/${Routes.MESSENGER}";

  @override
  String get eventName => "chat-message";

  @override
  String get channel => "room-chat-user-${getIt.get<UserCubit>().user.id}";

  @override
  Future<void> initialize(
      {required dynamic Function(PusherEvent)? onEvent}) async {
    try {
      await pusher.init(
        apiKey: PusherConfig.PUSHER_APP_KEY,
        cluster: PusherConfig.PUSHER_APP_CLUSTER,
        authParams: {
          'headers': apiService.headers,
        },
        useTLS: true,
        logToConsole: true,
        onError: (message, code, error) {
          log("onError: $message $code $error", name: "Pusher-chat-OnError");
        },
        onEvent: onEvent,
        onConnectionStateChange: (currentState, previousState) {
          log("onConnectionStateChange: $currentState",
              name: "Pusher-chat-onConnectionStateChange");
        },
      );
      await pusher.subscribe(channelName: channel);

      await pusher.connect();
    } catch (e) {
      log("ERROR: $e", name: "pusher-chat3w231`");
    }
  }

  @override
  Future<void> dispose() async {
    pusher.disconnect();
    pusher.unsubscribe(channelName: channel);
  }

  @override
  void handleData(BuildContext context, data) async {
    try {
      final convert = jsonDecode(data);

      final chat = ChatModel.fromJson(convert);

      if (chatLocation != currentLocation) {
        NotificationService.instance.createNotification(
          title: "Tin nhắn mới",
          body: chat.message,
          payload: chatLocation,
        );
        if (getIt.isRegistered<ChatCubit>()) {
          getIt.get<ChatCubit>().addChat(chat);
        }
      } else {
        getIt.get<ChatCubit>().addChat(chat);
      }
    } catch (e) {
      log("Error handle data Chat Pusher: $e");
    }
  }

  @override
  void trigger(PusherEvent event) async {
    await pusher.trigger(event);
  }
}
