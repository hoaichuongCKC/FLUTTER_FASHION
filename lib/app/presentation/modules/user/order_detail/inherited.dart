import 'package:flutter_fashion/app/models/order/order.dart';
import 'package:flutter_fashion/app/presentation/modules/user/home/export.dart';

class OrderDetailInherited extends InheritedWidget {
  final OrderModel order;
  final int status;

  const OrderDetailInherited(
      {required this.order,
      required this.status,
      super.key,
      required super.child});

  static OrderDetailInherited of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<OrderDetailInherited>()!;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
