// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:flutter_fashion/app/blocs/cart/cart_cubit.dart';
import 'package:flutter_fashion/app/models/cart/cart.dart';
import 'package:flutter_fashion/app/presentation/cart/components/counter_cart.dart';
import 'package:flutter_fashion/core/base/api/api.dart';
import 'package:flutter_fashion/utils/extensions/double.dart';
import '../../../../export.dart';

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
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: lightColor,
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
        boxShadow: [
          BoxShadow(
            color: disablePrimaryColor,
            blurRadius: 8.0,
          )
        ],
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
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1.0,
                        child: CachedNetworkImage(
                          imageUrl: ApiService.imageUrl +
                              item.product.product_detail![0].photo,
                          fit: BoxFit.fitWidth,
                          placeholder: (context, url) {
                            return ColoredBox(
                              color: skeletonColor,
                              child: const SizedBox(),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                        onTap: () => context
                                            .read<CartCubit>()
                                            .removeFromCart(index),
                                        child: FractionallySizedBox(
                                          alignment: const Alignment(0, -0.8),
                                          heightFactor: 0.35,
                                          child: SvgPicture.asset(
                                            "assets/icons/trash.svg",
                                            color: primaryColor,
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item.product.regular_price!
                                    .toDouble()
                                    .toVndCurrency(),
                                style: PrimaryFont.instance.copyWith(
                                  fontSize: 12.0,
                                  color: const Color(0xFFFF7262),
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              isItemCart
                                  ? CounterCart(
                                      value: item.quantity,
                                      ins: () =>
                                          context.read<CartCubit>().ins(index),
                                      des: () =>
                                          context.read<CartCubit>().des(index),
                                      onChanged: (p0) {
                                        log("counter $p0",
                                            name: "Counter-cart");
                                      },
                                    )
                                  : Text(
                                      'x${item.quantity}',
                                      style: PrimaryFont.instance.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: darkColor.withOpacity(0.5),
                                      ),
                                    )
                            ],
                          ),
                          item.product.sale_price == null
                              ? const SizedBox()
                              : ColoredBox(
                                  color: errorColor.withOpacity(0.2),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 1.0),
                                    child: Text(
                                      "-${item.product.sale_price!.toDouble().toVndCurrency()}",
                                      style: PrimaryFont.instance.copyWith(
                                        fontSize: 7.0,
                                        color: errorColor,
                                      ),
                                    ),
                                  ),
                                )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              item.color.isEmpty && item.size.isEmpty
                  ? const SizedBox()
                  : Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Chi tiết: ",
                            style: PrimaryFont.instance.copyWith(
                              fontSize: 14.0,
                              color: disableDarkColor,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const WidgetSpan(child: SizedBox(width: 5.0)),
                          TextSpan(
                            text: item.size,
                            style: PrimaryFont.instance.copyWith(
                              fontSize: 14.0,
                              color: disableDarkColor,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const WidgetSpan(child: SizedBox(width: 5.0)),
                          WidgetSpan(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Color(int.parse("0xFF${item.color}")),
                                shape: BoxShape.circle,
                              ),
                              child: const SizedBox(
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ),
                          const WidgetSpan(child: SizedBox(width: 5.0)),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
