import 'package:flutter_fashion/app/models/order/order.dart';
import 'package:flutter_fashion/app/presentation/modules/user/home/export.dart';
import 'package:flutter_fashion/utils/extensions/datetime.dart';
import '../components/show_action_buy_again.dart';

class ItemCancel extends StatelessWidget {
  const ItemCancel({
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'FC665',
                  style: PrimaryFont.instance.copyWith(fontSize: 16.0),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ColoredBox(
                      color: primaryColor.withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        child: Text(
                          AppLocalizations.of(context)!.canceled,
                          style: PrimaryFont.instance.copyWith(
                            fontSize: 9.0,
                            color: lightColor,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () =>
                          context.read<OrderCancelCubit>().remove(order.id!),
                      child: SvgPicture.asset(
                        Assets.trashSVG,
                        colorFilter: ColorFilter.mode(
                          textDisable,
                          BlendMode.srcIn,
                        ),
                        width: 20.0,
                        height: 20.0,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: order.order_detail!.map(
                  (e) {
                    return ListTile(
                      dense: true,
                      leading: SizedBox(
                        width: 60,
                        height: 60,
                        child: CachedNetworkImage(
                          imageUrl: ApiService.imageUrl + e.photo,
                          cacheKey: "${e.photo}order-cancel",
                        ),
                      ),
                      title: Text(
                        e.product.name!,
                        style: PrimaryFont.instance.copyWith(
                          fontSize: 12.0,
                        ),
                      ),
                      subtitle: Wrap(
                        spacing: 8.0,
                        runSpacing: 3.0,
                        children: [
                          Text(
                            e.price.toDouble().toVndCurrency(),
                            style: PrimaryFont.instance.copyWith(
                              fontSize: 10.0,
                              color: !(e.sale_price != null)
                                  ? const Color(0xFFFF7262)
                                  : disableDarkColor,
                              decoration: !(e.product.sale_price != null)
                                  ? null
                                  : TextDecoration.lineThrough,
                            ),
                          ),
                          e.sale_price != null
                              ? ColoredBox(
                                  color: errorColor.withOpacity(0.2),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 1.0),
                                    child: Text(
                                      "-${(e.price.toDouble() - e.price.toDouble()).toVndCurrency()}",
                                      style: PrimaryFont.instance.copyWith(
                                        fontSize: 7.0,
                                        fontWeight: FontWeight.w700,
                                        color: primaryColor.withAlpha(150),
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          !(e.sale_price != null)
                              ? const SizedBox()
                              : const SizedBox(width: 5.0),
                          !(e.sale_price != null)
                              ? const SizedBox()
                              : Text(
                                  e.sale_price!.toDouble().toVndCurrency(),
                                  style: PrimaryFont.instance.copyWith(
                                    fontSize: 10.0,
                                    height: 1.0,
                                    color: const Color(0xFFFF7262),
                                  ),
                                ),
                        ],
                      ),
                      trailing: Text(
                        "x${e.quantity}",
                        style: PrimaryFont.instance.copyWith(
                          fontSize: 8.0,
                          color: textDisable,
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: SvgPicture.asset(
                    Assets.calendarSVG,
                    colorFilter:
                        const ColorFilter.mode(secondaryColor, BlendMode.srcIn),
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  order.updated_at!.formatDateTime(),
                  style: PrimaryFont.instance.copyWith(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w300,
                    color: blackColor.withOpacity(0.5),
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
                      Assets.walletSVG,
                      colorFilter: const ColorFilter.mode(
                          secondaryColor, BlendMode.srcIn),
                      width: 18.0,
                      height: 19.0,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    order.total_price!.toDouble().toVndCurrency(),
                    style: PrimaryFont.instance.copyWith(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                      color: primaryColor.withAlpha(150),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ButtonWidget(
                height: 40.0,
                width: 130.0,
                onPressed: () => showActionBuyAgain(context, order),
                child: Text(
                  AppLocalizations.of(context)!.mua_lai,
                  style: PrimaryFont.instance.copyWith(
                    fontSize: 14.0,
                    color: lightColor,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
