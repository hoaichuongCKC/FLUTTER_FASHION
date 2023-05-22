import 'package:intl/intl.dart';

extension DoubleX on double {
  String toVndCurrency() {
    var formatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'VNĐ');
    return formatter.format(this);
  }
}
