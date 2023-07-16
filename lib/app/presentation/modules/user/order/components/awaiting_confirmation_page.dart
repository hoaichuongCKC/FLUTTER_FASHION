// ignore_for_file: deprecated_member_use
import 'package:flutter_fashion/app/presentation/modules/user/order/widgets/item_order.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';
import 'package:flutter_fashion/export.dart';

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

        if (state.status == AppStatus.success && state.toPayList.isEmpty) {
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
  const ShowDialogTimer({super.key, required this.onCancel});

  final VoidCallback onCancel;
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
    final applocalizations = AppLocalizations.of(context)!;
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(radiusBtn * 2),
        ),
      ),
      backgroundColor: lightColor,
      icon: Image.asset(
        Assets.warningPNG,
        width: 60,
        height: 60,
      ),
      surfaceTintColor: lightColor,
      title: Text(applocalizations.order_cancel),
      titleTextStyle: PrimaryFont.instance.copyWith(
        fontSize: 14.0,
        color: blackColor,
        fontWeight: FontWeight.w700,
      ),
      iconPadding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      contentTextStyle: PrimaryFont.instance.copyWith(
        fontSize: 12.0,
        color: blackColor,
        fontWeight: FontWeight.w300,
      ),
      content: Text(applocalizations.are_you_sure_cancel_order,
          textAlign: TextAlign.center),
      contentPadding: const EdgeInsets.fromLTRB(25, 8, 25, 8),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        ButtonWidget(
          onPressed: () {
            timer.cancel();
            AppRoutes.router.pop();
          },
          height: 30,
          width: 80,
          child: Text(
            applocalizations.cancel,
            style: PrimaryFont.instance.copyWith(
              color: lightColor,
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        ButtonWidget(
          onPressed: _counter == 0 ? widget.onCancel : null,
          height: 30,
          width: 80,
          child: Text(
            _counter == 0 ? applocalizations.ok : "0:0$_counter",
            style: PrimaryFont.instance.copyWith(
              color: lightColor,
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
