import 'package:intl/intl.dart';

extension DatetimeX on DateTime {
  String formatDateTime({bool isGetPM = true, bool isGetTime = true}) {
    final a = isGetPM ? 'a' : "";
    final b = isGetTime ? 'HH:mm' : "";
    final DateFormat formatter = DateFormat('yyyy-MM-dd $b $a');
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

  bool get checkNewProduct {
    DateTime currentDate = DateTime.now();

    int differenceInDays = currentDate.difference(this).inDays;

    if (differenceInDays <= 30) {
      return true;
    }
    return false;
  }

  bool get expiredCart {
    DateTime currentDate = DateTime.now();

    int differenceInDays = currentDate.difference(this).inDays;

    if (differenceInDays <= 14) {
      return true;
    }
    return false;
  }
}
