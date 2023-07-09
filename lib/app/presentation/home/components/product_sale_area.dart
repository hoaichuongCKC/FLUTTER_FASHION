import 'package:flutter_fashion/app/blocs/product_detail/product_detail_cubit.dart';
import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/common/components/item_product.dart';
import 'package:flutter_fashion/export.dart';

const defaultDuration = Duration(days: 2, hours: 2, minutes: 30);
const defaultPadding = EdgeInsets.symmetric(horizontal: 10, vertical: 5);

class ProductSaleArea extends StatelessWidget {
  const ProductSaleArea({super.key, required this.products});
  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: horizontalPadding - 4, vertical: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30.0),
            Text(
              "Sale",
              style: theme.textTheme.bodyLarge!.copyWith(
                fontSize: 20.0,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10.0),
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
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
