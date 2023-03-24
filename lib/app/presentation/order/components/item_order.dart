import 'package:flutter_fashion/app/presentation/order/components/awaiting_confirmation_page.dart';
import 'package:flutter_fashion/utils/extensions/datetime.dart';
import 'package:flutter_fashion/utils/extensions/double.dart';
import 'package:flutter_fashion/utils/extensions/int.dart';

import '../../../../export.dart';
import '../../../models/order/order.dart';

class ItemOrder extends StatelessWidget {
  const ItemOrder({
    super.key,
    required this.order,
  });
  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: lightColor,
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
        boxShadow: [BoxShadow(color: primaryColor, blurRadius: 8.0)],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Kira_Store',
                  style: PrimaryFont.instance.copyWith(fontSize: 18.0),
                ),
                ColoredBox(
                  color: primaryColor.withOpacity(0.5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    child: Text(
                      order.status!.getOrderStatus(),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: SvgPicture.asset(
                    "assets/icons/calendar.svg",
                    colorFilter:
                        const ColorFilter.mode(primaryColor, BlendMode.srcIn),
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  order.created_at!.formatDateTime(),
                  style: PrimaryFont.instance.copyWith(
                    fontSize: 14.0,
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
                    child: SvgPicture.asset(
                      "assets/icons/wallet.svg",
                      colorFilter:
                          const ColorFilter.mode(primaryColor, BlendMode.srcIn),
                      width: 18.0,
                      height: 19.0,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    order.total_price!.toDouble().toVndCurrency(),
                    style: PrimaryFont.instance.copyWith(
                      fontSize: 14.0,
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
    );
  }
}
