import 'package:intl/intl.dart';

extension DatetimeX on DateTime {
  String formatDateTime() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm a');
    final String formatted = formatter.format(this);
    return formatted;
  }

  String checkChatTime() {
    final currentTime = DateTime.now();

    if (year != currentTime.year ||
        month != currentTime.month ||
        day != currentTime.day) {
      final minuteString = minute < 10 ? "0$minute" : minute;
      return "${_getDate(weekday)} $hour:$minuteString";

      // return "$day/$month/$year";
    } else {
      final minuteString = minute < 10 ? "0$minute" : minute;
      return "$hour:$minuteString";
    }
  }

  String _getDate(int week) {
    switch (week) {
      case DateTime.monday:
        return "T2";
      case DateTime.tuesday:
        return "T3";
      case DateTime.wednesday:
        return "T4";
      case DateTime.thursday:
        return "T5";
      case DateTime.friday:
        return "T6";
      case DateTime.saturday:
        return "T7";
      default:
        return "CN";
    }
  }
}
