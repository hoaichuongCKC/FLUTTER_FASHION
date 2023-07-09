import 'package:flutter_fashion/app/presentation/cart/components/item_cart.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/app/presentation/order_detail/inherited.dart';
import 'package:flutter_fashion/utils/extensions/datetime.dart';
import 'package:flutter_fashion/utils/extensions/int.dart';

import '../../../../config/svg_files.dart';

class OrderDeliveredStatus extends StatelessWidget {
  const OrderDeliveredStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final order = OrderDetailInherited.of(context).order;
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Align(
              child: SvgPicture.asset(
                Assets.checkSuccessSVG,
                width: 100.0,
                height: 100.0,
              ),
            ),
          ),
          Align(
            child: Text(
              AppLocalizations.of(context)!.order_successful,
              style: PrimaryFont.instance.copyWith(
                fontSize: 16.0,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: SvgPicture.asset(
                  Assets.userSVG,
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
                      style: PrimaryFont.instance.copyWith(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300,
                        color: blackColor.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      order.shipping_phone!,
                      style: PrimaryFont.instance.copyWith(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300,
                        color: blackColor.withOpacity(0.5),
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
                  Assets.locationSVG,
                  colorFilter:
                      const ColorFilter.mode(secondaryColor, BlendMode.srcIn),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    order.shipping_address!,
                    style: PrimaryFont.instance.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300,
                      color: blackColor.withOpacity(0.5),
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
                Assets.calendarSVG,
                colorFilter:
                    const ColorFilter.mode(secondaryColor, BlendMode.srcIn),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  order.created_at!.formatDateTime(),
                  style: PrimaryFont.instance.copyWith(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                    color: blackColor.withOpacity(0.5),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          ListTile(
            dense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 3.0),
            minLeadingWidth: 0.0,
            horizontalTitleGap: 8.0,
            leading: SvgPicture.asset(Assets.orderBoxSVG),
            title: Text(
              AppLocalizations.of(context)!.orders_placed,
              style: PrimaryFont.instance.copyWith(
                fontSize: 16.0,
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
            separatorBuilder: (context, index) => const SizedBox(height: 10.0),
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
                      color: successfullyColor.withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        child: Text(
                          order.status_id!.getOrderStatus(context),
                          style: PrimaryFont.instance.copyWith(
                            fontSize: 10.0,
                            color: darkColor,
                            fontWeight: FontWeight.w300,
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
                          text: "${AppLocalizations.of(context)!.temp_price}: ",
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
        ],
      ),
    );
  }
}
