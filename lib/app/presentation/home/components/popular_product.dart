import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/common/components/item_product.dart';

class PopularHome extends StatelessWidget {
  const PopularHome({super.key, required this.listProduct});
  final List<ProductModel> listProduct;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
            child: ListTile(
              dense: true,
              minVerticalPadding: 0,
              contentPadding: EdgeInsets.zero,
              title: Text(
                AppLocalizations.of(context)!.popular,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                    ),
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
                  itemCount: listProduct.length + 1,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                      horizontal: horizontalPadding - 4),
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 20.0),
                  itemBuilder: (context, index) {
                    if (index == listProduct.length) {
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
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    final product = listProduct[index];
                    return SizedBox(
                      width: size.width * 0.45,
                      height: constraints.biggest.height,
                      child: ItemProduct(
                        product: listProduct[index],
                        onTap: () {
                          final bloc =
                              BlocProvider.of<ProductDetailCubit>(context);

                          bloc.getProduct(product.id!);

                          AppRoutes.router.pushNamed(Names.PRODUCT_DETAIL);
                        },
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

class PopularSkeleton extends StatelessWidget {
  const PopularSkeleton({super.key});

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
