import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../export.dart';

mixin PusherMixin {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
}

abstract class PusherApp {
  final String eventName = "";

  final String channel = "";

  Future<void> initialize({required dynamic Function(PusherEvent)? onEvent});

  void handleData(BuildContext context, dynamic data);

  Future<void> dispose();
}
