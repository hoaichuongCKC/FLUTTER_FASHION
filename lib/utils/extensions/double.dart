import 'package:intl/intl.dart';

extension DoubleX on double {
  String toVndCurrency() {
    var formatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'VNĐ');
    return formatter.format(this);
  }

  String viewStar() {
    if (this == this + 0.5) {
      return "$this";
    }
    return "${round().toDouble()}";
  }
}
