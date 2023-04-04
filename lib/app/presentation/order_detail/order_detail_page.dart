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
      case awaitingStatus:
        order = getIt.get<OrderCubit>().state.awaitingList[intIndex];
        break;
      case processingStatus:
        order = getIt.get<OrderCubit>().state.processingList[intIndex];
        break;
      case shippingStatus:
        order = getIt.get<OrderCubit>().state.shippingList[intIndex];
        break;
      case deliveredStatus:
        order = getIt.get<OrderCubit>().state.deliveredList[intIndex];
        break;
      default:
    }

    return OrderDetailInherited(
      order: order,
      status: intStatus,
      child: AppBackgroundBlur.normal(
        title: "Chi tiết đơn hàng",
        isHasBackground: false,
        child: intStatus == deliveredStatus
            ? const OrderDeliveredStatus()
            : const OrderAwaitingProcessingShippingDetail(),
      ),
    );
  }
}
