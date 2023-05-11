// ignore_for_file: deprecated_member_use
import 'package:flutter_fashion/app/presentation/home/export.dart';
import '../../../blocs/cart/cart_cubit.dart';

class DetailOrderView extends StatelessWidget {
  const DetailOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cartInfo = getIt.get<CartCubit>().state;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            minLeadingWidth: 0.0,
            leading: SvgPicture.asset(
              "assets/icons/receipt.svg",
              color: primaryColor,
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
              boxShadow: !ThemeDataApp.instance.isLight
                  ? null
                  : [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.2),
                        blurRadius: 8.0,
                      )
                    ],
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
                  const ItemDetailOrder(
                    title: "Giảm giá (đã áp dụng voucher)",
                    value: "-15.000VNĐ",
                  ),
                  const SizedBox(height: 8.0),
                  ItemDetailOrder(
                    title: AppLocalizations.of(context)!.total_amount,
                    value: cartInfo.totalCart().toDouble().toVndCurrency(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
