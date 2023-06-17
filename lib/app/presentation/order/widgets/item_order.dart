import 'package:flutter_fashion/utils/extensions/datetime.dart';
import 'package:flutter_fashion/utils/extensions/double.dart';
import 'package:flutter_fashion/utils/extensions/int.dart';

import '../../../../export.dart';
import '../../../models/order/order.dart';

class ItemOrder extends StatelessWidget {
  const ItemOrder({
    super.key,
    required this.order,
    required this.onPressed,
    this.index,
  });
  final OrderModel order;
  final int? index;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: lightColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),
        ),
        boxShadow: [shadowBox],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
              onTap: onPressed,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'You&Me',
                        style: PrimaryFont.instance.copyWith(fontSize: 16.0),
                      ),
                      ColoredBox(
                        color: secondaryColor.withOpacity(0.5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3.0),
                          child: Text(
                            order.status_id!.getOrderStatus(context),
                            style: PrimaryFont.instance.copyWith(
                              fontSize: 9.0,
                              color: lightColor,
                            ),
                          ),
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
                          colorFilter: const ColorFilter.mode(
                              secondaryColor, BlendMode.srcIn),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            order.shipping_address!,
                            style: PrimaryFont.instance.copyWith(
                              fontSize: 12.0,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: Hero(
                          tag: "calendar${order.id}",
                          child: SvgPicture.asset(
                            "assets/icons/calendar.svg",
                            colorFilter: const ColorFilter.mode(
                                secondaryColor, BlendMode.srcIn),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        order.created_at!.formatDateTime(),
                        style: PrimaryFont.instance.copyWith(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w300,
                          color: darkColor.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3.0),
                          child: Hero(
                            tag: "wallet${order.id}",
                            child: SvgPicture.asset(
                              "assets/icons/wallet.svg",
                              colorFilter: const ColorFilter.mode(
                                  secondaryColor, BlendMode.srcIn),
                              width: 18.0,
                              height: 19.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          order.total_price!.toDouble().toVndCurrency(),
                          style: PrimaryFont.instance.copyWith(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w300,
                            color: errorColor.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            order.status_id == deliveredStatus
                ? Align(
                    alignment: Alignment.centerRight,
                    child: order.evaluated!
                        ? DecoratedBox(
                            decoration: BoxDecoration(
                              color: disableDarkColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(radiusBtn),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                AppLocalizations.of(context)!.rated,
                                style: PrimaryFont.instance.copyWith(
                                  color: lightColor,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          )
                        : ButtonWidget(
                            height: 40.0,
                            width: 130.0,
                            onPressed: () {
                              AppRoutes.router.pushNamed(
                                Names.RATING_PRODUCT,
                                queryParams: {
                                  "order_id": order.id.toString(),
                                  "index": index.toString(),
                                },
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)!.rate_now,
                              style: PrimaryFont.instance.copyWith(
                                fontSize: 12.0,
                                color: lightColor,
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
