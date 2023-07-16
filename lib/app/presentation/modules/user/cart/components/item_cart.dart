import 'package:flutter_fashion/app/models/cart/cart.dart';
import 'package:flutter_fashion/app/presentation/modules/user/cart/components/counter_cart.dart';

import '../../../../../../export.dart';

class ItemCart extends StatelessWidget {
  const ItemCart(
      {super.key,
      required this.index,
      required this.item,
      this.isItemCart = true});
  final int index;
  final CartModel item;
  final bool isItemCart;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: lightColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),
        ),
        boxShadow: !ThemeDataApp.instance.isLight ? null : [shadowBox],
      ),
      child: SizedBox(
        height: 120.0,
        child: Padding(
          padding: const EdgeInsets.all(horizontalPadding / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildImage(),
                    const SizedBox(width: 8.0),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildName(context),
                          _buildPriceQuantity(theme, context),
                          item.sale_price != null
                              ? ColoredBox(
                                  color: errorColor.withOpacity(0.2),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 1.0),
                                    child: Text(
                                      "-${(item.price.toDouble() - item.sale_price!.toDouble()).toVndCurrency()}",
                                      style: PrimaryFont.instance.copyWith(
                                        fontSize: 7.0,
                                        color: errorColor,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              _buildDetail(context),
            ],
          ),
        ),
      ),
    );
  }

  Text _buildDetail(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "${AppLocalizations.of(context)!.detail}: ",
            style: PrimaryFont.instance.copyWith(
              fontSize: 12.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          item.size.isEmpty
              ? const WidgetSpan(child: SizedBox(width: 0.0))
              : TextSpan(
                  text: "size ",
                  style: PrimaryFont.instance.copyWith(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w300,
                  ),
                  children: [
                    TextSpan(
                      text: "${item.size}, ",
                      style: PrimaryFont.instance.copyWith(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w300,
                      ),
                    )
                  ],
                ),
          item.color.isEmpty
              ? const WidgetSpan(child: SizedBox(width: 0.0))
              : TextSpan(
                  text: "${AppLocalizations.of(context)!.color}: ",
                  style: PrimaryFont.instance.copyWith(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w300,
                  ),
                  children: [
                    WidgetSpan(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color(
                              int.parse("0xFF${item.color.substring(1)}")),
                          shape: BoxShape.circle,
                          boxShadow: item.color != "ffffff"
                              ? null
                              : const [
                                  BoxShadow(
                                    color: darkColor,
                                    blurRadius: 0.0,
                                    spreadRadius: 0.5,
                                    blurStyle: BlurStyle.inner,
                                  )
                                ],
                        ),
                        child: const SizedBox(
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ],
                ),
          const WidgetSpan(child: SizedBox(width: 5.0)),
        ],
      ),
    );
  }

  Row _buildPriceQuantity(ThemeData theme, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              item.price.toDouble().toVndCurrency(),
              style: theme.textTheme.bodySmall!.copyWith(
                fontSize: 10.0,
                color:
                    item.sale_price == null ? primaryColor : disableDarkColor,
                decoration:
                    item.sale_price == null ? null : TextDecoration.lineThrough,
              ),
            ),
            const SizedBox(width: 3.0),
            item.sale_price != null
                ? Text(
                    item.sale_price!.toDouble().toVndCurrency(),
                    style: PrimaryFont.instance.copyWith(
                      fontSize: 12.0,
                      color: const Color(0xFFFF7262),
                      fontWeight: FontWeight.w300,
                    ),
                  )
                : const SizedBox()
          ],
        ),
        isItemCart
            ? CounterCart(
                value: item.quantity,
                ins: () => context.read<CartCubit>().ins(index),
                des: () => context.read<CartCubit>().des(index),
              )
            : Text(
                'x${item.quantity}',
                style: PrimaryFont.instance.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: blackColor.withOpacity(0.5),
                ),
              )
      ],
    );
  }

  Expanded _buildName(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              item.product.name!,
              style: PrimaryFont.instance.copyWith(
                fontSize: 14.0,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          isItemCart
              ? InkWell(
                  onTap: () {
                    context.read<CartCubit>().removeFromCart(index, context);
                  },
                  child: FractionallySizedBox(
                    alignment: const Alignment(0, -0.8),
                    heightFactor: 0.35,
                    child: SvgPicture.asset(
                      Assets.trashSVG,
                      colorFilter: ColorFilter.mode(
                        textDisable,
                        BlendMode.srcIn,
                      ),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }

  Expanded _buildImage() {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: CachedNetworkImage(
          imageUrl: ApiService.imageUrl + item.photo,
          fit: BoxFit.fitWidth,
          placeholder: (context, url) {
            return ColoredBox(
              color: skeletonColor,
              child: const SizedBox(),
            );
          },
          cacheKey: item.photo,
        ),
      ),
    );
  }
}
