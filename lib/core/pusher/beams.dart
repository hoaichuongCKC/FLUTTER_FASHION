import 'dart:developer';
import 'package:flutter_fashion/app/presentation/modules/user/home/export.dart';
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

  void _onMessageReceivedInTheForeground(Map<dynamic, dynamic> data) {
    try {
      final type = data["data"]["type"];
      log(data.toString(), name: 'Beams data');
      if (type == PusherConfig.inNotification) {
        _handleNotificationPage(data);
      }
      if (type == PusherConfig.inOrder) {
        _handleOrderPage(data);
      }
    } catch (e) {
      log("==== == $e==== ===", name: 'Try catch Beams');
    }
  }

  _handleOrderPage(Map<dynamic, dynamic> data) =>
      NotificationService.instance.createNotification(
        title: data["title"].toString(),
        body: data["body"].toString(),
        payload: "${Routes.PROFILE}/${Routes.MY_ORDER}",
      );

  _handleNotificationPage(Map<dynamic, dynamic> data) =>
      NotificationService.instance.createNotification(
        title: data["title"].toString(),
        body: data["body"].toString(),
        payload: Routes.NOTIFICATION,
      );

  void dispose() async {
    await PusherBeams.instance.clearDeviceInterests();
    await PusherBeams.instance.clearAllState();
  }
}
