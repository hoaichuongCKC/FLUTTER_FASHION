import 'package:flutter_fashion/app/presentation/home/export.dart';

extension IntX on int {
  String formatNumber() {
    if (this < 1000) {
      return toString();
    }
    double num = this / 1000;
    if (num < 10) {
      return '${num.toStringAsFixed(1)}k';
    }
    return '${num.round()}k';
  }

  String getOrderStatus(BuildContext context) {
    switch (this) {
      case toShipStatus:
        return AppLocalizations.of(context)!.to_ship;
      case toReceive:
        return AppLocalizations.of(context)!.to_receive;
      case deliveredStatus:
        return AppLocalizations.of(context)!.completed;
      default:
        return AppLocalizations.of(context)!.to_pay;
    }
  }
}
