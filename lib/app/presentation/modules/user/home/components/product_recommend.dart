import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/presentation/modules/user/home/export.dart';
import 'package:flutter_fashion/common/components/item_product.dart';

class ProductRecommend extends StatelessWidget {
  const ProductRecommend({super.key, required this.listProduct});
  final List<ProductModel> listProduct;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            ListTile(
              dense: true,
              minVerticalPadding: 0,
              contentPadding: EdgeInsets.zero,
              title: Text(
                AppLocalizations.of(context)!.recommed_product,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ),
            GridView.builder(
              itemCount: listProduct.length,
              // controller: _scrollController,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2 / 4,
                mainAxisExtent: 240,
              ),
              itemBuilder: (context, index) {
                final product = listProduct[index];
                return ItemProduct(
                  product: listProduct[index],
                  onTap: () {
                    final bloc = BlocProvider.of<ProductDetailCubit>(context);

                    bloc.getProduct(product.id!);

                    AppRoutes.router.pushNamed(Names.PRODUCT_DETAIL);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
