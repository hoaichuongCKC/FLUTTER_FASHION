import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

abstract class PusherApp {
  final String eventName = "";

  final String channel = "";

  Future<void> initialize({required dynamic Function(PusherEvent)? onEvent});

  Future<void> dispose();
}

mixin PusherMixin {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
}
