import 'package:flutter_fashion/app/presentation/order/widgets/item_order.dart';
import '../../../../config/svg_files.dart';
import '../../../../core/status_cubit/status_cubit.dart';
import '../../../../export.dart';

class DeliveredView extends StatelessWidget {
  const DeliveredView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.completedList != current.completedList,
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
        if (state.status == AppStatus.success && state.completedList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  Assets.emptyListSVG,
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
        return ListView.separated(
          itemCount: state.completedList.length,
          padding:
              const EdgeInsets.only(top: 15.0, right: 10, left: 10, bottom: 15),
          separatorBuilder: (context, index) => const SizedBox(
            height: 15.0,
          ),
          itemBuilder: (context, index) => ItemOrder(
            index: index,
            onPressed: () {
              AppRoutes.router.pushNamed(
                Names.ORDER_DETAIL,
                queryParams: {
                  "index": index.toString(),
                  "status": deliveredStatus.toString()
                },
              );
            },
            order: state.completedList[index],
          ),
        );
      },
    );
  }
}
