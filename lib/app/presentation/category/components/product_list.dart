import 'dart:convert';
import 'package:flutter_fashion/app/presentation/category/blocs/category_tab_cubit.dart';
import 'package:flutter_fashion/common/components/item_product.dart';

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
    _bloc.initScroll();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BlocBuilder<CategoryTabCubit, CategoryTabState>(
          // buildWhen: (previous, current) => previous.data != current.data,
          builder: (context, state) {
            final data = state.data[state.currentId]["products"];

            if (data.isEmpty) {
              return Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context)!
                          .the_product_is_currently_out_of_stock),
                    ],
                  ),
                ),
              );
            }

            return Expanded(
              child: GridView.builder(
                controller: _bloc.controller,
                itemCount: data.length,
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
                  return ItemProduct(
                    product: data[index],
                    onTap: () => AppRoutes.router.pushNamed(
                      Names.PRODUCT_DETAIL,
                      params: {
                        "product": jsonEncode(data[index].toJson()),
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
