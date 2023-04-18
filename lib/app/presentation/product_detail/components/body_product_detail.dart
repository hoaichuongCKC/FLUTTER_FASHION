import 'package:flutter_fashion/app/presentation/cart/components/counter_cart.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/app/presentation/product_detail/components/option_color_size.dart';
import 'package:flutter_fashion/app/presentation/product_detail/components/tabbar_desc_reviews.dart';
import 'package:flutter_fashion/app/presentation/product_detail/cubit/product_detail_ui_cubit.dart';
import 'package:flutter_fashion/app/presentation/product_detail/inherited.dart';
import 'package:google_fonts/google_fonts.dart';

class BodyProductDetail extends StatelessWidget {
  const BodyProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final detailInherited = ProductDetailInherited.of(context);

    final product = detailInherited.productModel;

    final size = MediaQuery.of(context).size;

    final blocDetailUi = BlocProvider.of<ProductDetailUiCubit>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          height: size.height * 0.3,
          child: BlocBuilder<ProductDetailUiCubit, ProductDetailUiState>(
            buildWhen: (previous, current) =>
                previous.indexImage != current.indexImage,
            builder: (context, state) {
              final images = product.product_detail!;
              final image = images[state.indexImage];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: Column(
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10.0),
                            scrollDirection: Axis.vertical,
                            itemCount: images.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (ctx, index) {
                              final isSelected = state.indexImage == index;

                              final data = images[index];

                              final imageWidget = Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CachedNetworkImage(
                                  key: ValueKey(index),
                                  imageUrl: ApiService.imageUrl + data.photo,
                                  fit: BoxFit.contain,
                                  httpHeaders: getIt<ApiService>().headers,
                                  cacheKey: data.photo,
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
                                        onTap: () =>
                                            blocDetailUi.changeImage(index),
                                        child: imageWidget,
                                      )
                                    : DecoratedBox(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(radiusBtn)),
                                          border:
                                              Border.all(color: primaryColor),
                                        ),
                                        child: imageWidget,
                                      ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            product.regular_price!.toDouble().toVndCurrency(),
                            style: PrimaryFont.instance.copyWith(
                              fontSize: 12.0,
                              color: errorColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: CachedNetworkImage(
                      imageUrl: ApiService.imageUrl + image.photo,
                      fit: BoxFit.scaleDown,
                      httpHeaders: getIt<ApiService>().headers,
                      cacheKey: image.photo,
                      placeholder: (context, url) {
                        return ColoredBox(
                          color: skeletonColor,
                          child: const SizedBox(),
                        );
                      },
                    ),
                  )
                ],
              );
            },
          ),
        ),
        Text.rich(
          TextSpan(
            text: product.name,
            style: PrimaryFont.instance.copyWith(
              fontSize: 16.0,
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
                              "-${product.sale_price!.toDouble().toVndCurrency()}",
                              style: PrimaryFont.instance.copyWith(
                                fontSize: 14.0,
                                color: errorColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
              product.star == null || product.star == 0.0
                  ? const WidgetSpan(child: SizedBox())
                  : WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              product.star!.toStringAsFixed(1).toString(),
                              style: PrimaryFont.instance.copyWith(
                                fontSize: 12.0,
                              ),
                            ),
                            SvgPicture.asset("assets/icons/star.svg"),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
          textAlign: TextAlign.left,
          style: GoogleFonts.roboto(height: 1.0),
        ),
        product.sold == null
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${AppLocalizations.of(context)!.sold} | ${product.sold}",
                      style: PrimaryFont.instance.copyWith(
                        fontSize: 12.0,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Số lượng:  ",
                          style: PrimaryFont.instance.copyWith(
                            fontSize: 12.0,
                          ),
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
        const TabbarDescReviewsDetail(),
      ],
    );
  }
}
