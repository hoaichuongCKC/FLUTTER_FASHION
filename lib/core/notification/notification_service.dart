import 'package:flutter_fashion/export.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static NotificationService? _instance;
  static NotificationService get instance =>
      _instance ??= NotificationService._();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  late NotificationDetails _notificationDetails;

  late AndroidNotificationDetails _androidNotificationDetails;

  bool _isPlaySound = true;

  final timeZoneName = "Asia/Ho_Chi_Minh";

  NotificationService._() {
    _initialize();
    _initialTimezone();
  }

  set playSound(bool isPlaySound) {
    _isPlaySound = isPlaySound;
  }

  _initialize() async {
    // await _initSound();
    _flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      ),
      onSelectNotification: _handlePayload,
    );
    const sound = "cartoon_bubble";

    _androidNotificationDetails = AndroidNotificationDetails(
      'YouMe',
      'notification_pusher',
      'desc',
      importance: Importance.high,
      priority: Priority.high,
      playSound: _isPlaySound,
      sound: const RawResourceAndroidNotificationSound(sound),
    );

    _notificationDetails =
        NotificationDetails(android: _androidNotificationDetails);
  }

  _initialTimezone() {
    tz.initializeTimeZones();

    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future _handlePayload(String? payload) async {
    if (payload == Routes.NOTIFICATION) {
      AppRoutes.router.go(payload!);
      return;
    }
    AppRoutes.router.push(payload!);
  }

  void createNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      _notificationDetails,
      payload: payload,
    );
  }

  void createNotifiTimezone({int id = 0, String? title, String? body}) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      _notificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
    );
  }
}
