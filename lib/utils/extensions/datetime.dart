import 'package:intl/intl.dart';

extension DatetimeX on DateTime {
  String formatDateTime() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    final String formatted = formatter.format(this);
    return formatted;
  }
}
