import 'package:flutter/material.dart';
import 'package:flutter_fashion/app/blocs/order/order_cubit.dart';
import 'package:flutter_fashion/app/presentation/cart/components/item_cart.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/app/presentation/order/components/awaiting_confirmation_page.dart';
import 'package:flutter_fashion/utils/extensions/datetime.dart';
import 'package:flutter_fashion/utils/extensions/int.dart';

import '../../../common/components/app/background_app.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({super.key, required this.orderIndex});
  final String orderIndex;
  @override
  Widget build(BuildContext context) {
    final order =
        context.watch<OrderCubit>().state.awaitingList[int.parse(orderIndex)];

    return AppBackgroundBlur.normal(
      title: "Chi tiết đơn hàng",
      isHasBackground: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: SvgPicture.asset(
                    "assets/icons/user1.svg",
                    colorFilter:
                        const ColorFilter.mode(primaryColor, BlendMode.srcIn),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        "${order.shipping_fullname!},",
                        style: PrimaryFont.instance.copyWith(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300,
                          color: darkColor.withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        order.shipping_phone!,
                        style: PrimaryFont.instance.copyWith(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300,
                          color: darkColor.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    "assets/icons/location.svg",
                    colorFilter:
                        const ColorFilter.mode(primaryColor, BlendMode.srcIn),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      order.shipping_address!,
                      style: PrimaryFont.instance.copyWith(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300,
                        color: darkColor.withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/calendar.svg",
                  colorFilter:
                      const ColorFilter.mode(primaryColor, BlendMode.srcIn),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    order.created_at!.formatDateTime(),
                    style: PrimaryFont.instance.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300,
                      color: darkColor.withOpacity(0.5),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 3.0),
                  minLeadingWidth: 0.0,
                  horizontalTitleGap: 8.0,
                  leading: SvgPicture.asset("assets/icons/order_box.svg"),
                  title: Text(
                    'Đơn hàng đã đặt',
                    style: PrimaryFont.instance.copyWith(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                ListView.separated(
                  itemBuilder: (context, index) => ItemCart(
                    index: index,
                    item: order.order_detail![index],
                    isItemCart: false,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10.0),
                  itemCount: order.order_detail!.length,
                )
              ],
            ),
            const SizedBox(height: 15.0),
            Align(
              alignment: Alignment.centerRight,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Trạng thái: ",
                      style: PrimaryFont.instance.copyWith(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    WidgetSpan(
                      child: ColoredBox(
                        color: primaryColor.withOpacity(0.5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4.0, vertical: 3),
                          child: Text(
                            order.status!.getOrderStatus(),
                            style: PrimaryFont.instance.copyWith(
                              fontSize: 12.0,
                              color: lightColor,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Align(
              alignment: Alignment.centerRight,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Tổng đơn: ",
                      style: PrimaryFont.instance.copyWith(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    TextSpan(
                      text: order.total_price!.toDouble().toVndCurrency(),
                      style: PrimaryFont.instance.copyWith(
                        fontSize: 14.0,
                        color: errorColor,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            ButtonWidget(
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => const ShowDialogTimer(),
                );
              },
              height: 40,
              radius: 5,
              btnColor: primaryColor,
              animate: true,
              label: "Huỷ đơn hàng",
            ),
          ],
        ),
      ),
    );
  }
}
