import 'package:flutter_fashion/app/blocs/order_cancel/order_cancel_cubit.dart';

import '../../../../export.dart';
import '../widgets/item_cancel.dart';

class CancelOrderView extends StatelessWidget {
  const CancelOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCancelCubit, OrderCancelState>(
      builder: (context, state) {
        if (state.orders.isEmpty) {
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
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 14.0,
                      ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: state.orders.length,
          padding:
              const EdgeInsets.only(top: 15.0, right: 10, left: 10, bottom: 15),
          itemBuilder: (context, index) => ItemCancel(
            onPressed: () {},
            order: state.orders[index],
          ),
        );
      },
    );
  }
}
