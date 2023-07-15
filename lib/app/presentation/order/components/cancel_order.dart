import '../../../../config/svg_files.dart';
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
        // return Text(state.orders.length.toString());

        return ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            height: 15.0,
          ),
          itemCount: state.orders.length,
          padding:
              const EdgeInsets.only(top: 15.0, right: 10, left: 10, bottom: 15),
          itemBuilder: (context, index) =>
              ItemCancel(order: state.orders[index], onPressed: () {}),
        );
      },
    );
  }
}
