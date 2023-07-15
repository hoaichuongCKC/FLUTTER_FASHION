import 'package:intl/intl.dart';

extension DatetimeX on DateTime {
  String formatDateTime({bool isGetPM = true, bool isGetTime = true}) {
    final a = isGetPM ? 'a' : "";
    final b = isGetTime ? 'HH:mm' : "";
    final DateFormat formatter = DateFormat('yyyy-MM-dd $b $a');
    final String formatted = formatter.format(this);
    return formatted;
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
