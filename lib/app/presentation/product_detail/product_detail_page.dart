import 'package:flutter_fashion/app/presentation/product_detail/blocs/review_bloc.dart';
import 'package:flutter_fashion/app/presentation/product_detail/export_detail.dart';

import '../../../export.dart';
import 'components/botom_navigation_bar_detail.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key, required this.product});
  final ProductModel product;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late UiDetailShowBloc _uiDetailBloc;

  @override
  void initState() {
    super.initState();
    _uiDetailBloc = UiDetailShowBloc();

    _uiDetailBloc.init();

    if (widget.product.star != null) {
      getIt<ReviewBLoc>().fetchData(widget.product.id);
    }
  }

  @override
  void dispose() {
    super.dispose();

    _uiDetailBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProductDetailInherited(
      productModel: widget.product,
      bloc: _uiDetailBloc,
      child: Scaffold(
        bottomNavigationBar: const BottomNavigationbarDetail(),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverHeaderProduct(),
            const SliverSubImage(),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  ColoredBox(
                    color: lightColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: horizontalPadding - 4, vertical: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.name,
                            style: PrimaryFont.instance.copyWith(
                              fontSize: 18.0,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.product.regular_price
                                    .toDouble()
                                    .toVndCurrency(),
                                style: PrimaryFont.instance.copyWith(
                                  fontSize: 14.0,
                                  color: errorColor,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                    text: "Đã bán",
                                    style: PrimaryFont.instance.copyWith(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: ColoredBox(
                                        color: disableDarkColor,
                                        child: const SizedBox(
                                          width: 1.0,
                                          height: 20.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text: widget.product.sold.toString(),
                                    style: PrimaryFont.instance.copyWith(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ]),
                              ),
                            ],
                          ),
                          widget.product.star != null
                              ? Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: widget.product.star.toString(),
                                        style: PrimaryFont.instance.copyWith(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      WidgetSpan(
                                        child: SvgPicture.asset(
                                            "assets/icons/star.svg"),
                                      ),
                                    ],
                                  ),
                                )
                              : Text(
                                  "Chưa được đánh giá",
                                  style: PrimaryFont.instance.copyWith(
                                    fontSize: 14.0,
                                    color: disableDarkColor.withOpacity(0.5),
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                          const DescDetail(),
                          const ReviewDetail()
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
