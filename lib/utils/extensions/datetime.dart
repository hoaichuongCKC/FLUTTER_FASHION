import 'package:flutter_fashion/app/presentation/modules/user/home/export.dart';
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

  String viewDate(BuildContext context) {
    final DateTime currentDate = DateTime.now();
    if (currentDate.year != year) {
      final DateFormat formatter = DateFormat('yyyy-MM-dd');

      final String formatted = formatter.format(this);

      return formatted;
    }
    if (currentDate.month != month) {
      final DateFormat formatter = DateFormat('yyyy-MM-dd');

      final String formatted = formatter.format(this);

      return formatted;
    }
    final Duration difference = currentDate.difference(this);
    if (currentDate.day != day && difference.inHours >= 24) {
      final DateFormat formatter = DateFormat('yyyy-MM-dd');

      final String formatted = formatter.format(this);

      return formatted;
    }

    final applocal = AppLocalizations.of(context)!;

    if (difference.inHours != 0) {
      return "${difference.inHours} ${applocal.hour_left}";
    }
    if (difference.inMinutes != 0) {
      return "${difference.inMinutes} ${applocal.minutes_left}";
    }
    if (difference.inSeconds == 0) {
      return applocal.vua_xong;
    }

    return "${difference.inSeconds} ${applocal.second_left}";
  }
}
