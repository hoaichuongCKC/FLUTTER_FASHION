// ignore_for_file: deprecated_member_use

import 'package:flutter_fashion/app/presentation/home/export.dart';
import '../../../../export.dart';
import '../../../blocs/cart/cart_cubit.dart';

class DetailOrderView extends StatelessWidget {
  const DetailOrderView({super.key});

  @override
  Widget build(BuildContext context) {
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
              "assets/icons/bookmark.svg",
              color: primaryColor,
            ),
            title: Text(
              'Chi tiết đơn hàng',
              style: PrimaryFont.instance.copyWith(
                fontSize: 18.0,
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: lightColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(5.0),
              ),
              boxShadow: [
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
                    title: "Tạm tính",
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
                    title: "Thành tiền",
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textStyle ??
              PrimaryFont.instance.copyWith(
                fontSize: 14.0,
                color: darkColor.withOpacity(0.5),
                fontWeight: FontWeight.w300,
              ),
        ),
        Text(
          value,
          style: textStyleValue ??
              PrimaryFont.instance.copyWith(
                fontSize: 12.0,
                color: darkColor.withOpacity(0.5),
                fontWeight: FontWeight.w300,
              ),
        ),
      ],
    );
  }
}
