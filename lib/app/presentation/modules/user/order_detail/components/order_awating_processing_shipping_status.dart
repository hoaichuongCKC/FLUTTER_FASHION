import 'package:flutter_fashion/app/presentation/modules/user/cart/components/item_cart.dart';
import 'package:flutter_fashion/app/presentation/modules/user/home/export.dart';
import 'package:flutter_fashion/app/presentation/modules/user/order/components/awaiting_confirmation_page.dart';
import 'package:flutter_fashion/app/presentation/modules/user/order_detail/inherited.dart';
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: SvgPicture.asset(
                    Assets.userSVG,
                    width: 18.0,
                    height: 18,
                    colorFilter:
                        const ColorFilter.mode(secondaryColor, BlendMode.srcIn),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.locationSVG,
                    width: 20.0,
                    height: 20,
                    colorFilter:
                        const ColorFilter.mode(secondaryColor, BlendMode.srcIn),
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
                  Assets.calendarSVG,
                  width: 20.0,
                  height: 20,
                  colorFilter:
                      const ColorFilter.mode(secondaryColor, BlendMode.srcIn),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    order.updated_at!.formatDateTime(),
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            ListTile(
              dense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 3.0),
              minLeadingWidth: 0.0,
              horizontalTitleGap: 8.0,
              leading: SvgPicture.asset(Assets.orderBoxSVG),
              title: Text(
                AppLocalizations.of(context)!.my_order,
                style: theme.textTheme.bodyMedium,
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
            ),
            const SizedBox(height: 15.0),
            Align(
              alignment: Alignment.centerRight,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "${AppLocalizations.of(context)!.status}: ",
                      style: theme.textTheme.bodySmall,
                    ),
                    WidgetSpan(
                      child: ColoredBox(
                        color: darkColor.withOpacity(0.5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3.0),
                          child: Text(
                            order.status_id!.getOrderStatus(context),
                            style: PrimaryFont.instance.copyWith(
                              fontSize: 10.0,
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
            order.promotion != null
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "${AppLocalizations.of(context)!.temp_price}: ",
                            style: theme.textTheme.bodySmall,
                          ),
                          WidgetSpan(
                            child: Text(
                              order.temp_price!.toDouble().toVndCurrency(),
                              style: PrimaryFont.instance.copyWith(
                                fontSize: 10.0,
                                color: errorColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : const SizedBox(),
            order.promotion != null
                ? const SizedBox(
                    height: 8.0,
                  )
                : const SizedBox(),
            order.promotion != null
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "${AppLocalizations.of(context)!.promotion_applied}: ",
                            style: theme.textTheme.bodySmall!.copyWith(
                              color: successfullyColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          WidgetSpan(
                            child: Text(
                              (order.temp_price! *
                                      (order.promotion!.discount_price) /
                                      100)
                                  .toDouble()
                                  .toVndCurrency(),
                              style: PrimaryFont.instance.copyWith(
                                fontSize: 10.0,
                                color: errorColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : const SizedBox(),
            order.promotion != null
                ? const SizedBox(
                    height: 8.0,
                  )
                : const SizedBox(),
            Align(
              alignment: Alignment.centerRight,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "${AppLocalizations.of(context)!.total}: ",
                      style: theme.textTheme.bodySmall,
                    ),
                    WidgetSpan(
                      child: Text(
                        order.total_price!.toDouble().toVndCurrency(),
                        style: PrimaryFont.instance.copyWith(
                          fontSize: 10.0,
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
                          builder: (context) => ShowDialogTimer(
                            onCancel: () {
                              context
                                  .read<OrderCubit>()
                                  .delete(order.id!, context, order.status_id!);
                              context.read<OrderCancelCubit>().addOrder(order);
                            },
                          ),
                        );
                      },
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
