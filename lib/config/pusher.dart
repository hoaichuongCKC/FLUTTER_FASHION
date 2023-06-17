// ignore_for_file: constant_identifier_names

class PusherConfig {
  static const String PUSHER_APP_ID = "1573734";

  static const String PUSHER_APP_KEY = "b18a8b47f86b06965176";

  static const String PUSHER_APP_SECRET = "80eb6081c130837f9796";

  static const String PUSHER_APP_CLUSTER = "ap1";

  static const String PUSHER_BEAMS_INSTANCE_ID =
      "30cae1a9-74bd-4e10-9e22-d532bb53f8c9";

  static const String PUSHER_BEAMS_SECRET_KEY =
      "9014AA80071FD3E7A6D156E18A94C377AE2AB83E20294AD586D31A7D53FBB1BA";

  static const List<String> interests = ["user_notification", "user"];

  static String get inNotification => interests[0];

  static String get inOrder => interests[1];
}
