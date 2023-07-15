import 'package:flutter_fashion/app/models/order/order.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/utils/extensions/datetime.dart';

import '../../../../config/svg_files.dart';

showActionBuyAgain(BuildContext context, OrderModel order) {
  final size = MediaQuery.of(context).size;

  final applocalization = AppLocalizations.of(context)!;

  final theme = Theme.of(context);

  showModalBottomSheet(
    backgroundColor: lightColor,
    elevation: 0,
    isScrollControlled: true,
    constraints: BoxConstraints(
      minHeight: size.height * .6,
      maxHeight: size.height * 0.9,
    ),
    isDismissible: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radiusBtn * 2),
        topRight: Radius.circular(radiusBtn * 2),
      ),
    ),
    context: context,
    builder: (context) {
      return SizedBox(
        height: size.height * 0.9,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () => AppRoutes.router.pop(),
                  icon: const Icon(
                    Icons.clear,
                    size: 20,
                  ),
                ),
              ),
              Align(
                child: Text(
                  applocalization.order,
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    child: SvgPicture.asset(
                      Assets.userSVG,
                      width: 18.0,
                      height: 18,
                      colorFilter: const ColorFilter.mode(
                          secondaryColor, BlendMode.srcIn),
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
              const SizedBox(height: 8.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.calendarSVG,
                    colorFilter:
                        const ColorFilter.mode(secondaryColor, BlendMode.srcIn),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    order.created_at!.formatDateTime(),
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: order.order_detail!.map(
                  (e) {
                    return SizedBox(
                      height: 70.0,
                      child: ListTile(
                        dense: true,
                        leading: CachedNetworkImage(
                          imageUrl: ApiService.imageUrl + e.photo,
                          width: 70,
                          height: 70,
                        ),
                        title: Text(
                          e.product.name!,
                          style: PrimaryFont.instance.copyWith(
                            fontSize: 12.0,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              e.product.regular_price!
                                  .toDouble()
                                  .toVndCurrency(),
                              style: theme.textTheme.bodySmall!.copyWith(
                                fontSize: 10.0,
                                color: !(e.product.sale_price != null)
                                    ? const Color(0xFFFF7262)
                                    : disableDarkColor,
                                decoration: !(e.product.sale_price != null)
                                    ? null
                                    : TextDecoration.lineThrough,
                              ),
                            ),
                            e.product.sale_price != null
                                ? ColoredBox(
                                    color: errorColor.withOpacity(0.2),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 1.0),
                                      child: Text(
                                        "-${(e.product.regular_price!.toDouble() - e.product.sale_price!.toDouble()).toVndCurrency()}",
                                        style: PrimaryFont.instance.copyWith(
                                          fontSize: 7.0,
                                          color: errorColor,
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            !(e.product.sale_price != null)
                                ? const SizedBox()
                                : const SizedBox(width: 5.0),
                            !(e.product.sale_price != null)
                                ? const SizedBox()
                                : Text(
                                    e.product.sale_price!
                                        .toDouble()
                                        .toVndCurrency(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
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
                      ),
                    );
                  },
                ).toList(),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Text(
                    "${applocalization.status}: ",
                    style: PrimaryFont.instance.copyWith(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  ColoredBox(
                    color: primaryColor.withOpacity(0.5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: Text(
                        applocalization.canceled,
                        style: PrimaryFont.instance.copyWith(
                          fontSize: 9.0,
                          color: lightColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              order.promotion == null
                  ? const SizedBox()
                  : Row(
                      children: [
                        Text(
                          applocalization.promotions,
                          style: PrimaryFont.instance.copyWith(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            color: primaryColor.withAlpha(150),
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          "-${(order.temp_price! - order.total_price!).toDouble().toVndCurrency()}",
                          style: PrimaryFont.instance.copyWith(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            color: primaryColor.withAlpha(150),
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
              order.promotion == null
                  ? const SizedBox()
                  : const SizedBox(height: 8.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    "${applocalization.total_amount}: ",
                    style: PrimaryFont.instance.copyWith(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
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
              const Spacer(),
              ButtonWidget(
                onPressed: () => context
                    .read<OrderCancelCubit>()
                    .checkBuyAgain(context, order.id!),
                child: Text(
                  applocalization.mua_lai,
                  style: theme.textTheme.bodySmall!.copyWith(
                    fontSize: 14.0,
                    color: lightColor,
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
            ],
          ),
        ),
      );
    },
  );
}
