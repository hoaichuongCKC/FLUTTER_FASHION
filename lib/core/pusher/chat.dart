import 'dart:developer';
import 'package:flutter_fashion/app/blocs/user/user_cubit.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/config/pusher.dart';
import 'package:flutter_fashion/core/pusher/pusher_app.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherChatApp with PusherMixin implements PusherApp {
  final ApiService apiService;

  PusherChatApp({required this.apiService}) {
    log("Initial PusherAppChat");
  }

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
          log("onConnectionStateChange: $currentState,,,, $previousState",
              name: "Pusher-chat-onConnectionStateChange");
        },
        // authEndpoint: "<Your Authendpoint>",
        // onAuthorizer: onAuthorizer
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
}
