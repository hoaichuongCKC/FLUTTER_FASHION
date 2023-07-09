import 'package:flutter_fashion/app/blocs/payment/payment.dart';
import 'package:flutter_fashion/app/blocs/payment/payment_state.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:lottie/lottie.dart';

class RulesAppView extends StatelessWidget {
  const RulesAppView({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final applocalization = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                WidgetSpan(
                  child: BlocBuilder<PaymentCubit, PaymentState>(
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
                                decoration: BoxDecoration(
                                  color: ThemeDataApp.instance.isLight
                                      ? darkColor
                                      : theme.cardColor,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(3.0),
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () => context
                                      .read<PaymentCubit>()
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
                                  color: theme.cardColor,
                                  border: !ThemeDataApp.instance.isLight
                                      ? null
                                      : Border.all(color: darkColor),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(3.0),
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () => context
                                      .read<PaymentCubit>()
                                      .readRule(true),
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
                  text: applocalization!.please_carefully_read_the,
                  style: theme.textTheme.bodySmall,
                ),
                TextSpan(
                  text: " ${applocalization.the_terms_and_conditions} ",
                  style: theme.textTheme.bodySmall!.copyWith(
                    color: secondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: applocalization.of_the_store_is_return_policy,
                  style: theme.textTheme.bodySmall,
                )
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          ButtonWidget(
            onPressed: () {
              context.read<PaymentCubit>().order(context);
            },
            height: 45.0,
            child: Text(
              AppLocalizations.of(context)!.check_it_out,
              style: PrimaryFont.instance.copyWith(
                color: lightColor,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
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
      surfaceTintColor: lightColor,
      backgroundColor: lightColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(radiusBtn),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              "assets/json/16982-shopping-loader.json",
              controller: _controller,
              onLoaded: (p0) {
                _controller.duration = p0.duration;
                _controller.repeat();
              },
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.please_await,
              style: PrimaryFont.instance.copyWith(
                fontSize: 14.0,
                color: darkColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
