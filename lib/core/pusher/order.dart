import 'dart:developer';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/config/pusher.dart';
import 'package:flutter_fashion/core/pusher/pusher_app.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherOrderApp with PusherMixin implements PusherApp {
  final ApiService apiService;

  PusherOrderApp({required this.apiService});

  String get currentLocation => AppRoutes.router.location;

  String get orderLocation => "${Routes.PROFILE}/${Routes.MY_ORDER}";

  @override
  String get eventName => "update-order";

  @override
  String get channel => "order-user-${getIt.get<UserCubit>().user.id}";

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
          log("onError: $message $code $error", name: "Pusher-order-OnError");
        },
        onEvent: onEvent,
        onConnectionStateChange: (currentState, previousState) {
          log("onConnectionStateChange: $currentState",
              name: "Pusher-order-onConnectionStateChange");
        },
        // authEndpoint: "<Your Authendpoint>",
        // onAuthorizer: onAuthorizer
      );
      await pusher.subscribe(channelName: channel);

      await pusher.connect();
    } catch (e) {
      log("ERROR: $e", name: "pusher-order`");
    }
  }

  @override
  Future<void> dispose() async {
    pusher.disconnect();
    pusher.unsubscribe(channelName: channel);
  }

  @override
  void handleData(BuildContext context, data) async {
    try {} catch (e) {
      log("Error handle data Chat Pusher: $e");
    }
  }

  @override
  void trigger(PusherEvent event) {}
}
