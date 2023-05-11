import 'package:flutter_fashion/app/blocs/order/order_cubit.dart';
import 'package:flutter_fashion/app/presentation/order/components/item_order.dart';

import '../../../../core/status_cubit/status_cubit.dart';
import '../../../../export.dart';

class OrderProcessingPage extends StatelessWidget {
  const OrderProcessingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.toShipList != current.toShipList,
      builder: (context, state) {
        if (state.status == AppStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.status == AppStatus.error) {
          return const Center(
            child: Text('Server Error'),
          );
        }
        if (state.status == AppStatus.success && state.toShipList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/empty_list.svg",
                  width: 80.0,
                  height: 80.0,
                ),
                const SizedBox(height: 10.0),
                Text(
                  AppLocalizations.of(context)!.you_currently_have_no_orders,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          itemCount: state.toShipList.length,
          padding:
              const EdgeInsets.only(top: 15.0, right: 10, left: 10, bottom: 15),
          itemBuilder: (context, index) => ItemOrder(
            onPressed: () {
              AppRoutes.router.pushNamed(
                Names.ORDER_DETAIL,
                queryParams: {
                  "index": index.toString(),
                  "status": toPayStatus.toString()
                },
              );
            },
            order: state.toShipList[index],
          ),
        );
      },
    );
  }
}
