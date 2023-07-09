// ignore_for_file: deprecated_member_use, unnecessary_null_comparison
import 'package:flutter_fashion/app/blocs/payment/payment.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import '../../../../config/svg_files.dart';
import '../../../blocs/cart/cart_cubit.dart';
import '../../../blocs/payment/payment_state.dart';

class DetailOrderView extends StatelessWidget {
  const DetailOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cartInfo = getIt.get<CartCubit>().state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          minLeadingWidth: 0.0,
          leading: SvgPicture.asset(
            Assets.receiptSVG,
            color: secondaryColor,
          ),
          title: Text(
            AppLocalizations.of(context)!.order_detail,
            style: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(radiusBtn),
            ),
            boxShadow: !ThemeDataApp.instance.isLight ? null : [shadowBox],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ItemDetailOrder(
                  title: AppLocalizations.of(context)!.sub_total,
                  value: cartInfo.totalCart().toDouble().toVndCurrency(),
                  textStyleValue: PrimaryFont.instance.copyWith(
                    fontSize: 12.0,
                    color: errorColor,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 8.0),
                BlocBuilder<PaymentCubit, PaymentState>(
                  buildWhen: (p, c) => p.promotion != c.promotion,
                  builder: (context, state) {
                    if (state.promotion.id == 0) {
                      return ItemDetailOrder(
                        title: AppLocalizations.of(context)!
                            .promotion_not_yet_applied,
                        value: 0.0.toVndCurrency(),
                      );
                    }
                    return ItemDetailOrder(
                      title:
                          "${AppLocalizations.of(context)!.promotions} (${AppLocalizations.of(context)!.promotion_applied})",
                      textStyleValue: PrimaryFont.instance.copyWith(
                        fontSize: 12.0,
                        color: errorColor,
                        fontWeight: FontWeight.w300,
                      ),
                      value:
                          "-${(cartInfo.totalCart() * (state.promotion.discount_price / 100)).toDouble().toVndCurrency()}",
                    );
                  },
                ),
                const SizedBox(height: 8.0),
                BlocBuilder<PaymentCubit, PaymentState>(
                  buildWhen: (p, c) => p.promotion != c.promotion,
                  builder: (context, state) {
                    if (state.promotion == null) {
                      return ItemDetailOrder(
                        title: AppLocalizations.of(context)!.total_amount,
                        value: cartInfo.totalCart().toDouble().toVndCurrency(),
                      );
                    }
                    return ItemDetailOrder(
                      title: AppLocalizations.of(context)!.total_amount,
                      value: (cartInfo.totalCart() -
                              cartInfo.totalCart() *
                                  (state.promotion.discount_price / 100))
                          .toDouble()
                          .toVndCurrency(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ItemDetailOrder extends StatelessWidget {
  const ItemDetailOrder(
      {super.key,
      required this.title,
      required this.value,
      this.textStyle,
      this.textStyleValue});
  final String title;
  final String value;
  final TextStyle? textStyle;
  final TextStyle? textStyleValue;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textStyle ?? theme.textTheme.bodySmall,
        ),
        Text(
          value,
          style: textStyleValue ?? theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}
