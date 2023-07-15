import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/common/components/item_product.dart';

import '../../../../export.dart';

class ProductNewMonth extends StatelessWidget {
  const ProductNewMonth({super.key, required this.products});
  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
            child: Text(
              AppLocalizations.of(context)!.new_product,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ),
          ConstrainedBoxWidget(
            currentHeight: .4,
            maxHeight: 250,
            minHeight: 240,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final size = MediaQuery.of(context).size;
                return ListView.separated(
                    itemCount: products.length + 1,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: horizontalPadding - 4),
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 20.0),
                    itemBuilder: (context, index) {
                      if (index == products.length) {
                        return GestureDetector(
                          onTap: () => AppRoutes.router.pushNamed(
                            Names.CATEGORY,
                            queryParams: {
                              "index": "0",
                            },
                          ),
                          child: SizedBox(
                            width: size.width * 0.45,
                            height: constraints.biggest.height,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  DecoratedBox(
                                    decoration: const BoxDecoration(
                                      color: lightColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: SvgPicture.asset(
                                        "assets/icons/all.svg",
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    AppLocalizations.of(context)!.view_all,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      final product = products[index];
                      return SizedBox(
                        width: size.width * 0.45,
                        height: constraints.biggest.height,
                        child: ItemProduct(
                          product: products[index],
                          onTap: () {
                            final bloc =
                                BlocProvider.of<ProductDetailCubit>(context);

                            bloc.getProduct(product.id!);

                            AppRoutes.router.pushNamed(Names.PRODUCT_DETAIL);
                          },
                        ),
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SkeletonNewProductHome extends StatelessWidget {
  const SkeletonNewProductHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        child: ConstrainedBoxWidget(
          currentHeight: .4,
          maxHeight: 250,
          minHeight: 240,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final size = MediaQuery.of(context).size;
              return ListView.separated(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                    horizontal: horizontalPadding - 4),
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) =>
                    const SizedBox(width: 20.0),
                itemBuilder: (context, index) {
                  return ColoredBox(
                    color: skeletonColor,
                    child: SizedBox(
                      width: size.width * 0.45,
                      height: constraints.biggest.height,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
