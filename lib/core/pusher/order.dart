import 'dart:convert';
import 'dart:developer';
import 'package:flutter_fashion/app/blocs/notification/notification_cubit.dart';
import 'package:flutter_fashion/app/blocs/order/order_cubit.dart';
import 'package:flutter_fashion/app/models/notification/notification_model.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/config/pusher.dart';
import 'package:flutter_fashion/core/pusher/pusher_app.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherUserApp with PusherMixin implements PusherApp {
  final ApiService apiService;

  PusherUserApp({required this.apiService});

  String get currentLocation => AppRoutes.router.location;

  String get orderLocation => "${Routes.PROFILE}/${Routes.MY_ORDER}";

  @override
  String get eventName => "pusher-user";

  @override
  String get channel => "pusher-user-${getIt.get<UserCubit>().user.id}";

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
          log("onError: $message $code $error", name: "Pusher-OnError");
        },
        onEvent: onEvent,
        onConnectionStateChange: (currentState, previousState) {
          log(
            "onConnectionStateChange: $currentState",
            name: "Pusher-onConnectionStateChange",
          );
        },
        //   authEndpoint: "${ApiService.baseUrl}",
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
  void handleData(data) async {
    try {
      final dataConvert = jsonDecode(data);

      if (dataConvert["type"] == typeOrder) {
        _updateOrder(dataConvert);
      } else if (dataConvert['type'] == typeNotification) {
        _createNotification(dataConvert);
      }
    } catch (e) {
      log("Error handle data Pusher: $e");
    }
  }

  @override
  void trigger(PusherEvent event) {}

  void _updateOrder(data) {
    if (getIt.isRegistered<OrderCubit>()) {
      getIt.get<OrderCubit>().updateStatus(
            data["data"]["order_id"],
            data["data"]["new_status"],
          );
    }
  }

  void _createNotification(data) {
    if (getIt.isRegistered<NotificationCubit>()) {
      final notification = NotificationModel.fromJson(data["data"]);

      getIt.get<NotificationCubit>().add(notification);
    }
  }
}
