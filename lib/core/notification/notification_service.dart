import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  late NotificationDetails _notificationDetails;

  late AndroidNotificationDetails _androidNotificationDetails;

  NotificationService._() {
    _initialize();
    _initialTimezone();
  }

  _initialize() async {
    _flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      ),
    );

    _androidNotificationDetails = const AndroidNotificationDetails(
      'your_channel_id_0',
      'pushnotification',
      'desc',
      importance: Importance.max,
      priority: Priority.high,
      showProgress: true,
    );

    _notificationDetails =
        NotificationDetails(android: _androidNotificationDetails);
  }

  _initialTimezone() {
    tz.initializeTimeZones();
    const timeZoneName = "Asia/Ho_Chi_Minh";
    tz.setLocalLocation(tz.getLocation(timeZoneName));
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
