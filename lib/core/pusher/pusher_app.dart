import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../export.dart';

mixin PusherMixin {
  final String typeOrder = "order";
  final String typeNotification = "notification";

  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
}

abstract class PusherApp {
  final String eventName = "";

  final String channel = "";

  Future<void> initialize({required dynamic Function(PusherEvent)? onEvent});

  void trigger(PusherEvent event);

  void handleData(dynamic data);

  Future<void> dispose();
}
