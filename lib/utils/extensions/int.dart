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

  String getOrderStatus() {
    switch (this) {
      case processingStatus:
        return "Đang chuẩn bị";
      case shippingStatus:
        return "Đang giao";
      case deliveredStatus:
        return "Đã giao";
      default:
        return "Chờ xác nhận";
    }
  }
}
