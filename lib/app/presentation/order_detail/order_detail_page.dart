import 'package:flutter_fashion/app/blocs/order/order_cubit.dart';
import 'package:flutter_fashion/app/models/order/order.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/app/presentation/order_detail/components/order_awating_processing_shipping_status.dart';
import 'package:flutter_fashion/app/presentation/order_detail/inherited.dart';
import '../../../common/components/app/background_app.dart';
import 'components/order_delivered_status.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage(
      {super.key, required this.orderIndex, required this.status});
  final String orderIndex;
  final String status;
  @override
  Widget build(BuildContext context) {
    final intIndex = int.parse(orderIndex);
    final intStatus = int.parse(status);
    late OrderModel order;

    switch (intStatus) {
      case toPayStatus:
        order = getIt.get<OrderCubit>().state.toPayList[intIndex];
        break;
      case toShipStatus:
        order = getIt.get<OrderCubit>().state.toShipList[intIndex];
        break;
      case toReceive:
        order = getIt.get<OrderCubit>().state.toReceiveList[intIndex];
        break;
      case deliveredStatus:
        order = getIt.get<OrderCubit>().state.completedList[intIndex];
        break;
      default:
    }

    return OrderDetailInherited(
      order: order,
      status: intStatus,
      child: AppBackgroundBlur.normal(
        title: AppLocalizations.of(context)!.order_detail,
        isHasBackground: false,
        child: intStatus == deliveredStatus
            ? const OrderDeliveredStatus()
            : const ToPayShipReceiveDetail(),
      ),
    );
  }
}
