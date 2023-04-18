import 'package:flutter_fashion/app/blocs/product_detail/product_detail_cubit.dart';
import 'package:flutter_fashion/app/presentation/product_detail/components/app_bar_product_detail.dart';
import 'package:flutter_fashion/app/presentation/product_detail/components/body_product_detail.dart';
import 'package:flutter_fashion/app/presentation/product_detail/cubit/product_detail_ui_cubit.dart';
import 'package:flutter_fashion/app/presentation/product_detail/export_detail.dart';

import '../../../export.dart';
import 'components/botom_navigation_bar_detail.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailCubit, ProductDetailState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox(),
          loading: () => const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          failure: (error) =>
              Scaffold(body: Center(child: Center(child: Text(error)))),
          success: (product, reviews) => ProductDetailInherited(
            productModel: product,
            child: BlocProvider(
              create: (context) => ProductDetailUiCubit(),
              child: Scaffold(
                extendBody: false,
                bottomNavigationBar: const BottomNavigationbarDetail(),
                body: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: horizontalPadding - 4),
                  child: Column(
                    children: const [
                      AppBarProductDetail(),
                      BodyProductDetail(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
