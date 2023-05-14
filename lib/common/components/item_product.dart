import 'package:flutter_fashion/app/blocs/favorite/favorite_cubit.dart';
import 'package:flutter_fashion/app/blocs/user/user_cubit.dart';
import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/common/widgets/flash_sale_widget.dart';
import 'package:flutter_fashion/common/widgets/new_widget.dart';
import 'package:flutter_fashion/common/widgets/popular.dart';
import 'package:flutter_fashion/core/base/api/api.dart';
import 'package:flutter_fashion/utils/extensions/datetime.dart';
import 'package:flutter_fashion/utils/extensions/double.dart';
import 'package:flutter_fashion/utils/extensions/int.dart';
import '../../export.dart';

class ItemProduct extends StatelessWidget {
  const ItemProduct({
    super.key,
    required this.product,
    required this.onTap,
  });
  final ProductModel product;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final image = product.product_detail![0].photo;

    final isPopular = product.is_popular;

    final isSale = product.sale_price != null;

    final isNew = product.created_at!.checkNewProduct;

    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        AspectRatio(
                          aspectRatio: 4 / 3,
                          child: CachedNetworkImage(
                            imageUrl: ApiService.imageUrl + image,
                            fit: BoxFit.fitWidth,
                            httpHeaders: getIt<ApiService>().headers,
                            cacheKey: image,
                            placeholder: (context, url) {
                              return ColoredBox(
                                color: skeletonColor,
                                child: const SizedBox(),
                              );
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 3,
                          left: 0,
                          child: Row(
                            children: [
                              isSale
                                  ? const FlashSaleWidget()
                                  : const SizedBox(),
                              isSale
                                  ? const SizedBox(width: 2)
                                  : const SizedBox(),
                              isNew ? const NewWidget() : const SizedBox()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            product.name!,
                            style: theme.textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product.regular_price!.toDouble().toVndCurrency(),
                              style: theme.textTheme.bodySmall!.copyWith(
                                fontSize: 10.0,
                                color: !isSale
                                    ? const Color(0xFFFF7262)
                                    : disableDarkColor,
                                decoration:
                                    !isSale ? null : TextDecoration.lineThrough,
                              ),
                            ),
                            isSale
                                ? ColoredBox(
                                    color: errorColor.withOpacity(0.2),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 1.0),
                                      child: Text(
                                        "-${(product.regular_price!.toDouble() - product.sale_price!.toDouble()).toVndCurrency()}",
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
                        !isSale
                            ? const SizedBox()
                            : Text(
                                product.sale_price!.toDouble().toVndCurrency(),
                                style: theme.textTheme.bodySmall!.copyWith(
                                  fontSize: 10.0,
                                  height: 1.0,
                                  color: const Color(0xFFFF7262),
                                ),
                              ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${AppLocalizations.of(context)!.sold}: ${product.sold!.formatNumber()}',
                                  style: theme.textTheme.bodySmall!.copyWith(
                                    fontSize: 10.0,
                                  ),
                                ),
                                const SizedBox(width: 5.0),
                                isPopular!
                                    ? const PopularWidget()
                                    : const SizedBox(),
                              ],
                            ),
                            SvgPicture.asset(
                              "assets/icons/shipping_delivery.svg",
                              colorFilter: ColorFilter.mode(
                                ThemeDataApp.instance.isLight
                                    ? darkColor
                                    : lightColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const SizedBox(),
                    loading: () => const SizedBox(),
                    failure: (error) => const SizedBox(),
                    fetchCompleted: (user) =>
                        BlocSelector<FavoriteCubit, FavoriteState, bool>(
                      selector: (state) {
                        final favorites = state.listProduct;

                        if (favorites.isEmpty) {
                          return false;
                        }
                        final bool isCheck = favorites
                            .any((element) => element.id == product.id);
                        return isCheck;
                      },
                      builder: (context, state) {
                        if (!state) {
                          return const SizedBox();
                        }
                        return CustomPaint(
                          size:
                              Size(constraints.maxWidth, constraints.maxHeight),
                          painter: FavoritePainter(),
                        );
                      },
                    ),
                  );
                },
              ),
              product.sale_price == null
                  ? const SizedBox()
                  : Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          "-${product.discount!.toInt()}%",
                          style: theme.textTheme.bodySmall!.copyWith(
                            fontSize: 12,
                            color: lightColor,
                          ),
                        ),
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}

class FavoritePainter extends CustomPainter {
  FavoritePainter();
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = errorColor.withOpacity(0.8);
    canvas.drawRect(
        Rect.fromLTWH(-5, 5, size.width * .4, size.height * 0.07), paint);
    // Tạo một đối tượng TextPainter để vẽ chữ trên canvas
    final textPainter = TextPainter(
      text: TextSpan(
        text: '+ Yêu thích',
        style: PrimaryFont.instance.copyWith(
          fontSize: 9,
          color: lightColor,
        ),
      ),
      textDirection: TextDirection.rtl,
    );

    // Căn chỉnh văn bản trung tâm trong hình chữ nhật
    textPainter.layout(minWidth: 0, maxWidth: size.width);
    final x = (-5 + size.width * .4 / 2) - textPainter.width / 2;
    final y = 5 + size.height * 0.07 / 2 - textPainter.height / 2;

    // Vẽ văn bản trên canvas
    textPainter.paint(canvas, Offset(x, y));

    // Xác định các điểm của tam giác
    final trianglePath = Path()
      ..moveTo(-5, 5 + size.height * 0.07)
      ..lineTo(0, 5 + size.height * 0.07)
      ..lineTo(0, 5 + size.height * 0.07 + 7)
      ..close();
    final trianglePaint = Paint()..color = errorColor;
    // Vẽ tam giác trên canvas
    canvas.drawPath(trianglePath, trianglePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
