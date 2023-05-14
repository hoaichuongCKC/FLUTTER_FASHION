import 'package:flutter_fashion/app/presentation/cart/components/item_cart.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/app/presentation/order/components/awaiting_confirmation_page.dart';
import 'package:flutter_fashion/app/presentation/order_detail/inherited.dart';
import 'package:flutter_fashion/utils/extensions/datetime.dart';
import 'package:flutter_fashion/utils/extensions/int.dart';

class ToPayShipReceiveDetail extends StatelessWidget {
  const ToPayShipReceiveDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final order = OrderDetailInherited.of(context).order;
    final status = OrderDetailInherited.of(context).status;
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
      child: Material(
        surfaceTintColor: Colors.transparent,
        color: Colors.transparent,
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
                        style: theme.textTheme.bodySmall,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        order.shipping_phone!,
                        style: theme.textTheme.bodySmall,
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
                      style: theme.textTheme.bodySmall,
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
                    style: theme.textTheme.bodySmall,
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
                    AppLocalizations.of(context)!.my_order,
                    style: theme.textTheme.bodyLarge,
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
                      text: "${AppLocalizations.of(context)!.status}: ",
                      style:
                          theme.textTheme.bodySmall!.copyWith(fontSize: 14.0),
                    ),
                    WidgetSpan(
                      child: ColoredBox(
                        color: primaryColor.withOpacity(0.5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4.0, vertical: 3),
                          child: Text(
                            order.status!.getOrderStatus(context),
                            style: theme.textTheme.bodySmall,
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
                      text: "${AppLocalizations.of(context)!.total}: ",
                      style:
                          theme.textTheme.bodySmall!.copyWith(fontSize: 14.0),
                    ),
                    WidgetSpan(
                      child: Text(
                        order.total_price!.toDouble().toVndCurrency(),
                        style: PrimaryFont.instance.copyWith(
                          fontSize: 14.0,
                          color: errorColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            status <= 2
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: ButtonWidget(
                      onPressed: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) =>
                              ShowDialogTimer(orderId: order.id!),
                        );
                      },
                      height: 40,
                      child: Text(
                        AppLocalizations.of(context)!.cancel,
                        style: PrimaryFont.instance.copyWith(
                          color: lightColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
