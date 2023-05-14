// ignore_for_file: deprecated_member_use

import 'package:flutter_fashion/app/blocs/order/order_cubit.dart';
import 'package:flutter_fashion/app/presentation/order/components/item_order.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';
import '../../../../export.dart';

class ToPay extends StatelessWidget {
  const ToPay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.toPayList != current.toPayList,
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
        print("===================${state}=======================");
        if (state.status == AppStatus.success && state.toPayList.isEmpty) {
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
        return ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 15.0),
          itemCount: state.toPayList.length,
          padding:
              const EdgeInsets.only(top: 15.0, right: 10, left: 10, bottom: 15),
          itemBuilder: (context, index) => ItemOrder(
            order: state.toPayList[index],
            onPressed: () {
              AppRoutes.router.pushNamed(
                Names.ORDER_DETAIL,
                queryParams: {
                  "index": index.toString(),
                  "status": toPayStatus.toString()
                },
              );
            },
          ),
        );
      },
    );
  }
}

class ShowDialogTimer extends StatefulWidget {
  const ShowDialogTimer({super.key, required this.orderId});
  final int orderId;
  @override
  State<ShowDialogTimer> createState() => _ShowDialogTimerState();
}

class _ShowDialogTimerState extends State<ShowDialogTimer> {
  late Timer timer;
  int _counter = 5;
  Duration intervalDuration = const Duration(seconds: 1);
  @override
  void initState() {
    timer = Timer.periodic(intervalDuration, (timer) {
      if (_counter == 0) {
        timer.cancel();
        return;
      }
      _counter--;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: lightColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14.0),
          topRight: Radius.circular(14.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DecoratedBox(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14.0),
                topRight: Radius.circular(14.0),
              ),
              color: primaryColor,
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .8,
              height: 14.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding - 4, vertical: verticalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Bạn muốn huỷ đơn?',
                  style: PrimaryFont.instance.copyWith(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ButtonWidget(
                      onPressed: () {
                        timer.cancel();
                        AppRoutes.router.pop();
                      },
                      height: 30,
                      width: 55,
                      child: Text(
                        "bỏ",
                        style: PrimaryFont.instance.copyWith(
                          color: lightColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    ButtonWidget(
                      onPressed: _counter == 0
                          ? () => context
                              .read<OrderCubit>()
                              .delete(widget.orderId, context)
                          : () {},
                      height: 30,
                      width: 55,
                      child: Text(
                        _counter == 0 ? "Ok" : "00:0$_counter",
                        style: PrimaryFont.instance.copyWith(
                          color: lightColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
