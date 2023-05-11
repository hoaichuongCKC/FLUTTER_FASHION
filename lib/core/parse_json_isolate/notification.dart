import 'dart:convert';

import 'package:flutter_fashion/app/models/notification/notification_model.dart';

List<NotificationModel> parseJson(String params) {
  final notifications = jsonDecode(params);

  final notificationList = NotificationModel.notiModelFromJson(notifications);

  return (notificationList);
}
