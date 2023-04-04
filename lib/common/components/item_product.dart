import 'package:flutter_fashion/app/blocs/favorite/favorite_cubit.dart';
import 'package:flutter_fashion/app/blocs/user/user_cubit.dart';
import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/core/base/api/api.dart';
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
    return InkWell(
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: CachedNetworkImage(
                    imageUrl:
                        ApiService.imageUrl + product.product_detail![0].photo,
                    fit: BoxFit.fitWidth,
                    httpHeaders: getIt<ApiService>().headers,
                    placeholder: (context, url) {
                      return ColoredBox(
                        color: skeletonColor,
                        child: const SizedBox(),
                      );
                    },
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        product.name!,
                        style: PrimaryFont.instance
                            .copyWith(fontSize: 14.0, height: 1.5),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.regular_price!.toDouble().toVndCurrency(),
                            style: PrimaryFont.instance.copyWith(
                              fontSize: 12.0,
                              color: const Color(0xFFFF7262),
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          product.sale_price != null
                              ? ColoredBox(
                                  color: errorColor.withOpacity(0.2),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 1.0),
                                    child: Text(
                                      "-${product.sale_price!.toDouble().toVndCurrency()}",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.sold}: ${product.sold!.formatNumber()}',
                          style: PrimaryFont.instance.copyWith(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SvgPicture.asset(
                          "assets/icons/shipping_delivery.svg",
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
                  selector: (state) => state.listProduct.contains(product),
                  builder: (context, state) {
                    if (!state) {
                      return const SizedBox();
                    }
                    return CustomPaint(
                      painter: FavoritePainter(),
                    );
                  },
                ),
              );
            },
          ),
        ],
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
      text: const TextSpan(
        text: 'Đã yêu thích',
        style: TextStyle(
          fontSize: 11,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
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
    return true;
  }
}

class ItemProductSkeleton extends StatelessWidget {
  const ItemProductSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.0,
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: ColoredBox(
                color: skeletonColor,
                child: const SizedBox(),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: ColoredBox(
                    color: skeletonColor,
                    child: const SizedBox(),
                  ),
                ),
                const SizedBox(height: 5.0),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: ColoredBox(
                    color: skeletonColor,
                    child: const SizedBox(),
                  ),
                ),
                const SizedBox(height: 5.0),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: ColoredBox(
                    color: skeletonColor,
                    child: const SizedBox(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
