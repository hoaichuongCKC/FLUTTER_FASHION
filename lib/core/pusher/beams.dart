import 'dart:developer';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/config/pusher.dart';
import 'package:flutter_fashion/core/base/api/endpoint.dart';
import 'package:flutter_fashion/core/notification/notification_service.dart';
import 'package:pusher_beams/pusher_beams.dart';

class PusherBeamsApp {
  PusherBeamsApp._();

  static final PusherBeamsApp instance = PusherBeamsApp._();

  Future<void> getStarted() async =>
      await PusherBeams.instance.start(PusherConfig.PUSHER_BEAMS_INSTANCE_ID);

  Future<void> initDeviceIntest() async =>
      await PusherBeams.instance.setDeviceInterests(PusherConfig.interests);

  Future<void> initToUser(int userId) async =>
      await PusherBeams.instance.setUserId(
        userId.toString(),
        BeamsAuthProvider()
          ..authUrl = ApiService.baseUrl + ApiEndpoint.authBeams
          ..headers = getIt.get<ApiService>().headers
          ..queryParams = {}
          ..credentials = 'omit',
        (value) {
          if (value != null) log(value);
        },
      );

  void onMessageReceivedInTheForeground() async {
    if (!kIsWeb) {
      await PusherBeams.instance.onInterestChanges(
        (interests) => {
          log('Interests: $interests', name: "Beams-interest"),
        },
      );

      await PusherBeams.instance
          .onMessageReceivedInTheForeground(_onMessageReceivedInTheForeground);
    }
  }

  void _onMessageReceivedInTheForeground(Map<dynamic, dynamic> data) async =>
      _handleSendNoti(data);

  _handleSendNoti(Map<dynamic, dynamic> data) {
    final type = data["data"]["type"];

    if (type == PusherConfig.inNotification) {
      final isNoti = AppRoutes.router.location == Routes.NOTIFICATION;

      if (isNoti) _handleNotificationPage(data);
    }
  }

  _handleNotificationPage(Map<dynamic, dynamic> data) =>
      NotificationService.instance.createNotification(
        title: data["title"].toString(),
        body: data["body"].toString(),
      );

  void dispose() async {
    await PusherBeams.instance.clearDeviceInterests();
    await PusherBeams.instance.clearAllState();
  }
}
