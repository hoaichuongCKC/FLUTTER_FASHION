import 'dart:math';

import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/utils/extensions/int.dart';
import 'package:rxdart/rxdart.dart';

class PopularHome extends StatefulWidget {
  const PopularHome({super.key, required this.listProduct});
  final List<ProductModel> listProduct;

  @override
  State<PopularHome> createState() => _PopularHomeState();
}

class _PopularHomeState extends State<PopularHome> {
  late PageController _pageController;

  double viewPort = 0.85;

  late BehaviorSubject<double> _streamController;

  @override
  void initState() {
    super.initState();
    _streamController = BehaviorSubject.seeded(0.0);
    _pageController = PageController(viewportFraction: viewPort)
      ..addListener(() {
        _streamController.sink.add(_pageController.page!);
      });
  }

  @override
  void dispose() {
    _streamController.close();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = PrimaryFont.instance.copyWith(
      fontSize: 16.0,
    );
    return SliverToBoxAdapter(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
            child: ListTile(
              dense: true,
              minVerticalPadding: 0,
              contentPadding: EdgeInsets.zero,
              title: Text(
                AppLocalizations.of(context)!.popular,
                style: PrimaryFont.instance.large(),
              ),
            ),
          ),
          ConstrainedBoxWidget(
            currentHeight: .25,
            maxHeight: 130,
            minHeight: 90,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.listProduct.length,
              itemBuilder: (context, index) {
                final data = widget.listProduct[index];
                return StreamBuilder<double>(
                  stream: _streamController.stream,
                  builder: (context, snapshot) {
                    double pageOffset = snapshot.data ?? 0.0;

                    double scale = max(
                        viewPort, (1 - (pageOffset - index).abs()) + viewPort);

                    double angle = (pageOffset - index).abs();

                    if (angle > 0.5) {
                      angle = 1 - angle;
                    }

                    return Padding(
                      padding: EdgeInsets.only(
                        right: index == 0 ? 10.0 : 8.0,
                        left: index == 0 ? 0.0 : 8.0,
                        top: 20 - scale * 10,
                        bottom: 8.0,
                      ),
                      child: Transform(
                        transform: Matrix4.identity()
                          ..setEntry(
                            3,
                            2,
                            0.001,
                          )
                          ..rotateY(angle),
                        alignment: Alignment.center,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: lightColor,
                            border: Border.all(color: primaryColor),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(radiusBtn),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: CachedNetworkImage(
                                  imageUrl: ApiService.imageUrl +
                                      data.product_detail![0].photo,
                                  fit: BoxFit.contain,
                                  httpHeaders: getIt.get<ApiService>().headers,
                                  placeholder: (context, url) {
                                    return ColoredBox(
                                      color: skeletonColor,
                                      child: const SizedBox(),
                                    );
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.name!,
                                        style: textStyle.copyWith(
                                          fontSize: 14.0,
                                        ),
                                        maxLines: 2,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            data.regular_price!
                                                .toDouble()
                                                .toVndCurrency(),
                                            style:
                                                PrimaryFont.instance.copyWith(
                                              fontSize: 12.0,
                                              color: const Color(0xFFFF7262),
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          const SizedBox(width: 5.0),
                                          data.sale_price != null
                                              ? ColoredBox(
                                                  color: errorColor
                                                      .withOpacity(0.2),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 1.0),
                                                    child: Text(
                                                      "-${data.sale_price!.toDouble().toVndCurrency()}",
                                                      style: PrimaryFont
                                                          .instance
                                                          .copyWith(
                                                        fontSize: 7.0,
                                                        color: errorColor,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox()
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            '${AppLocalizations.of(context)!.sold}: ${data.sold ?? 0.formatNumber()}',
                                            style:
                                                PrimaryFont.instance.copyWith(
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
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PopularSearchSkeleton extends StatelessWidget {
  const PopularSearchSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
          child: ColoredBox(
            color: skeletonColor,
            child: const SizedBox(
              width: 60,
              height: 15.0,
            ),
          ),
        ),
        const SizedBox(height: 15.0),
        SizedBox(
          height: 110,
          child: GridView.builder(
            itemCount: 4,
            shrinkWrap: true,
            padding:
                const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 16 / 9,
              mainAxisExtent: 50.0,
            ),
            itemBuilder: (context, index) {
              return ColoredBox(color: skeletonColor);
            },
          ),
        ),
      ],
    );
  }
}
