import 'package:flutter_fashion/app/blocs/product_detail/product_detail_cubit.dart';

import 'package:flutter_fashion/app/presentation/category/blocs/category_tab_cubit.dart';
import 'package:flutter_fashion/common/components/item_product.dart';
import 'package:flutter_fashion/common/widgets/skeleton_grid_view.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';

import '../../../../export.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late CategoryTabCubit _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<CategoryTabCubit>(context)..initScroll();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<CategoryTabCubit, CategoryTabState>(
            buildWhen: (previous, current) =>
                previous.products != current.products ||
                previous.status != current.status,
            builder: (context, state) {
              final products = state.products;

              final isLoading = state.status == AppStatus.loading;

              if (isLoading) {
                return const Expanded(
                  child: SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
                    child: SkeletonGridView(),
                  ),
                );
              }
              if (products.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.no_products,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Expanded(
                child: GridView.builder(
                  controller: _bloc.controller,
                  itemCount: products.length,
                  padding: const EdgeInsets.symmetric(
                      horizontal: horizontalPadding - 4, vertical: 10.0),
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
                      key: ValueKey(product),
                      product: product,
                      onTap: () {
                        final bloc =
                            BlocProvider.of<ProductDetailCubit>(context);

                        bloc.getProduct(product.id!);

                        AppRoutes.router.pushNamed(Names.PRODUCT_DETAIL);
                      },
                    );
                  },
                ),
              );
            },
          ),
          BlocBuilder<CategoryTabCubit, CategoryTabState>(
            buildWhen: (previous, current) =>
                previous.loading != current.loading,
            builder: (context, state) {
              final loading = state.loading;
              if (loading) {
                return Center(
                  child: Text(
                    AppLocalizations.of(context)!.loading,
                    style: PrimaryFont.instance.copyWith(
                      fontSize: 12.0,
                      color: primaryColor,
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }
}
