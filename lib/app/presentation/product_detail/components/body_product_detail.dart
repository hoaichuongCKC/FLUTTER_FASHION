import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/presentation/cart/components/counter_cart.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/app/presentation/product_detail/components/option_color_size.dart';
import 'package:flutter_fashion/app/presentation/product_detail/components/tabbar_desc_reviews.dart';
import 'package:flutter_fashion/app/presentation/product_detail/cubit/product_detail_ui_cubit.dart';
import 'package:flutter_fashion/common/widgets/popular.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/svg_files.dart';

class BodyProductDetail extends StatelessWidget {
  const BodyProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductModel product =
        InheritedDataApp.of<ProductModel>(context)!.data;

    final size = MediaQuery.of(context).size;

    final blocDetailUi = BlocProvider.of<ProductDetailUiCubit>(context);

    final theme = Theme.of(context);

    final images = product.product_detail;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          height: size.height * 0.3,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: blackColor.withOpacity(0.03),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(radiusBtn / 2),
                    ),
                  ),
                  child:
                      BlocBuilder<ProductDetailUiCubit, ProductDetailUiState>(
                    buildWhen: (p, c) => p.color != c.color,
                    builder: (context, state) {
                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 5.0),
                        scrollDirection: Axis.vertical,
                        itemCount: images!.length,
                        itemBuilder: (ctx, index) {
                          if (index != 0) {
                            final isPhoto =
                                images[index - 1].photo == images[index].photo;
                            if (isPhoto) return const SizedBox();
                          }

                          final image = images[index];

                          final isSelected = state.color == image.color;

                          final imageWidget = Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CachedNetworkImage(
                              key: ValueKey(index),
                              imageUrl: ApiService.imageUrl + image.photo,
                              fit: BoxFit.contain,
                              httpHeaders: getIt<ApiService>().headers,
                              cacheKey: image.photo,
                              width: size.width * 0.1,
                              height: size.width * 0.1,
                              placeholder: (context, url) {
                                return ColoredBox(
                                  color: skeletonColor,
                                  child: const SizedBox(),
                                );
                              },
                            ),
                          );
                          return AnimatedSwitcher(
                            switchInCurve: Curves.linearToEaseOut,
                            switchOutCurve: Curves.fastLinearToSlowEaseIn,
                            duration: const Duration(milliseconds: 500),
                            child: !isSelected
                                ? InkWell(
                                    onTap: () => blocDetailUi.selectImage(
                                        image.color!, index),
                                    child: imageWidget,
                                  )
                                : DecoratedBox(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(radiusBtn)),
                                      border: Border.all(color: darkColor),
                                    ),
                                    child: imageWidget,
                                  ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: LayoutBuilder(builder: (context, constraints) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      BlocBuilder<ProductDetailUiCubit, ProductDetailUiState>(
                        buildWhen: (p, c) => p.indexImage != c.indexImage,
                        builder: (context, state) {
                          return CachedNetworkImage(
                            imageUrl: ApiService.imageUrl +
                                images![state.indexImage].photo,
                            fit: BoxFit.scaleDown,
                            httpHeaders: getIt.get<ApiService>().headers,
                            cacheKey: images[state.indexImage].photo,
                            placeholder: (context, url) {
                              return ColoredBox(
                                color: skeletonColor,
                                child: const SizedBox(),
                              );
                            },
                          );
                        },
                      ),
                      product.sale_price == null
                          ? const SizedBox()
                          : Positioned(
                              top: 0,
                              right: 0,
                              width: constraints.biggest.width * .25,
                              height: constraints.biggest.height * .15,
                              child: Container(
                                padding: const EdgeInsets.all(5.0),
                                decoration: const BoxDecoration(
                                  color: Colors.amber,
                                  shape: BoxShape.rectangle,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(Assets.tagSVG),
                                    const SizedBox(width: 3.0),
                                    Text(
                                      "-${product.discount!.toInt()}%",
                                      style:
                                          theme.textTheme.bodySmall!.copyWith(
                                        fontSize: 12,
                                        color: blackColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  );
                }),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text.rich(
            TextSpan(
              text: product.name,
              style: theme.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w500,
              ),
              children: [
                product.sale_price == null
                    ? const WidgetSpan(child: SizedBox())
                    : WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ColoredBox(
                            color: errorColor.withOpacity(0.2),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 1.0),
                              child: Text(
                                "-${(product.regular_price!.toDouble() - product.sale_price!.toDouble()).toVndCurrency()}",
                                style: PrimaryFont.instance.copyWith(
                                  fontSize: 10.0,
                                  color: errorColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
            textAlign: TextAlign.left,
            style: GoogleFonts.roboto(height: 1.0),
          ),
        ),
        Row(
          children: [
            Text(
              product.regular_price!.toDouble().toVndCurrency(),
              style: theme.textTheme.bodySmall!.copyWith(
                color: product.sale_price == null
                    ? const Color(0xFFFF7262)
                    : disableDarkColor,
                decoration: product.sale_price == null
                    ? null
                    : TextDecoration.lineThrough,
                fontWeight: product.sale_price == null ? FontWeight.w600 : null,
              ),
            ),
            const SizedBox(width: 8.0),
            product.sale_price == null
                ? const SizedBox()
                : Text(
                    product.sale_price!.toDouble().toVndCurrency(),
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: const Color(0xFFFF7262),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ],
        ),
        product.sold == null
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${AppLocalizations.of(context)!.sold}: ${product.sold} | ",
                          style: theme.textTheme.bodySmall,
                        ),
                        product.is_popular!
                            ? const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                child: PopularWidget(),
                              )
                            : const SizedBox(),
                        product.star == null || product.star == 0.0
                            ? const SizedBox()
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    double.parse(
                                            product.star!.toStringAsFixed(1))
                                        .toString(),
                                    style: theme.textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    Assets.starSVG,
                                    colorFilter: ColorFilter.mode(
                                      starColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.quantity(""),
                          style: theme.textTheme.bodySmall,
                        ),
                        CounterCart(
                          onChanged: (p0) => blocDetailUi.changeQuantity(p0),
                          iconSize: 20.0,
                        ),
                      ],
                    )
                  ],
                ),
              ),
        const OptionColorSizeDetail(),
        const SizedBox(height: 8.0),
        const Divider(),
        const TabbarDescReviewsDetail(),
        const SizedBox(height: 100.0),
      ],
    );
  }
}
