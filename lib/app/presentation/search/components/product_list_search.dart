import 'package:flutter_fashion/app/blocs/product_detail/product_detail_cubit.dart';

import 'package:flutter_fashion/app/blocs/search/search_cubit.dart';
import 'package:flutter_fashion/common/components/item_product.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';

import '../../../../export.dart';

class ProductListSearch extends StatelessWidget {
  const ProductListSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        final products = state.products;

        final status = state.status;
        if (status == AppStatus.loading) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
              ],
            ),
          );
        }
        if (products.isEmpty && status == AppStatus.init) {
          return const SizedBox();
        }

        if (products.isEmpty && status == AppStatus.success) {
          return Text(
            AppLocalizations.of(context)!.not_found_search_result,
            style: Theme.of(context).textTheme.bodySmall,
          );
        }
        return GridView.builder(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          itemCount: products.length,
          // controller: _scrollController,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 2 / 4,
            mainAxisExtent: 230.0,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return ItemProduct(
              product: product,
              onTap: () {
                final bloc = BlocProvider.of<ProductDetailCubit>(context);

                bloc.getProduct(product.id!);

                AppRoutes.router.pushNamed(Names.PRODUCT_DETAIL);
              },
            );
          },
        );
      },
    );
  }
}
