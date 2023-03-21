import 'package:flutter_fashion/app/blocs/payment/payment.dart';
import 'package:flutter_fashion/app/blocs/payment/payment_state.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';
import 'package:flutter_fashion/utils/alert/pop_up.dart';
import 'package:lottie/lottie.dart';

class RulesAppView extends StatelessWidget {
  const RulesAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                WidgetSpan(
                  child: BlocBuilder<OrderCubit, OrderState>(
                    buildWhen: (previous, current) =>
                        previous.isRead != current.isRead,
                    builder: (context, state) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        switchInCurve: Curves.fastLinearToSlowEaseIn,
                        switchOutCurve: Curves.fastOutSlowIn,
                        child: state.isRead
                            ? DecoratedBox(
                                key: const ValueKey(true),
                                decoration: const BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(3.0),
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () => context
                                      .read<OrderCubit>()
                                      .readRule(false),
                                  child: const SizedBox(
                                    width: 18.0,
                                    height: 18.0,
                                    child: Center(
                                      child: Icon(
                                        Icons.check,
                                        size: 15.0,
                                        color: lightColor,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : DecoratedBox(
                                key: const ValueKey(false),
                                decoration: BoxDecoration(
                                  color: lightColor,
                                  border: Border.all(color: primaryColor),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(3.0),
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () =>
                                      context.read<OrderCubit>().readRule(true),
                                  child:
                                      const SizedBox(width: 18.0, height: 18.0),
                                ),
                              ),
                      );
                    },
                  ),
                ),
                const WidgetSpan(child: SizedBox(width: 5.0)),
                TextSpan(
                  text: "Vui lòng đọc kĩ về ",
                  style: PrimaryFont.instance.copyWith(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                TextSpan(
                  text: "điều khoản & chính sách ",
                  style: PrimaryFont.instance.copyWith(
                    fontSize: 12.0,
                    color: primaryColor,
                  ),
                ),
                TextSpan(
                  text: "đổi trả, nhận hàng của cửa hàng",
                  style: PrimaryFont.instance.copyWith(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          ButtonWidget(
            btnColor: primaryColor,
            animate: true,
            onPressed: () {
              context.read<OrderCubit>().order(context);
            },
            height: 45.0,
            label: "Thanh toán",
          ),
        ],
      ),
    );
  }
}

showOrder(BuildContext context) {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) => const DialogOrder(),
  );
}

class DialogOrder extends StatefulWidget {
  const DialogOrder({
    super.key,
  });

  @override
  State<DialogOrder> createState() => _DialogOrderState();
}

class _DialogOrderState extends State<DialogOrder>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: lightColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<OrderCubit, OrderState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              builder: (context, state) {
                if (state.status == AppStatus.success) {
                  return Lottie.asset(
                    "assets/json/order-success.json",
                    controller: _controller,
                    onLoaded: (p0) {
                      _controller.duration = p0.duration;
                      _controller.repeat();
                    },
                  );
                }
                return Lottie.asset(
                  "assets/json/order-received.json",
                  controller: _controller,
                  onLoaded: (p0) {
                    _controller.duration = p0.duration;
                    _controller.repeat();
                  },
                );
              },
            ),
            BlocBuilder<OrderCubit, OrderState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              builder: (context, state) {
                if (state.status == AppStatus.success) {
                  return const SizedBox();
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10.0),
                    Text(
                      'Vui lòng đợi...',
                      style: PrimaryFont.instance.copyWith(
                        fontSize: 14.0,
                        color: primaryColor,
                      ),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
