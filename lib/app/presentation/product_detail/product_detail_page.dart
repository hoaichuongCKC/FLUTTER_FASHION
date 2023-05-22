import 'package:flutter_fashion/app/blocs/product_detail/product_detail_cubit.dart';
import 'package:flutter_fashion/app/presentation/product_detail/components/app_bar_product_detail.dart';
import 'package:flutter_fashion/app/presentation/product_detail/components/body_product_detail.dart';
import 'package:flutter_fashion/app/presentation/product_detail/components/tabbar_desc_reviews.dart';
import 'package:flutter_fashion/app/presentation/product_detail/cubit/product_detail_ui_cubit.dart';
import 'package:flutter_fashion/app/presentation/product_detail/export_detail.dart';

import '../../../export.dart';
import 'components/botom_navigation_bar_detail.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    return BlocBuilder<ProductDetailCubit, ProductDetailState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox(),
          loading: () => const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          failure: (error) => Scaffold(body: Center(child: Text(error))),
          success: (product, reviews) => InheritedDataApp<ProductModel>(
            data: product,
            child: BlocProvider(
              create: (context) => ProductDetailUiCubit(),
              child: Scaffold(
                extendBody: true,
                floatingActionButton:
                    BlocBuilder<ProductDetailUiCubit, ProductDetailUiState>(
                  buildWhen: (p, c) => p.isShow != c.isShow,
                  builder: (context, state) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      reverseDuration: const Duration(milliseconds: 500),
                      child: state.isShow
                          ? DecoratedBox(
                              key: const ValueKey("button"),
                              decoration: BoxDecoration(
                                  color: lightColor,
                                  shape: BoxShape.circle,
                                  boxShadow: [shadowBox]),
                              child: IconButton(
                                onPressed: () => controller.animateTo(
                                  0,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.linear,
                                ),
                                icon: const Icon(
                                  Icons.arrow_upward_sharp,
                                  size: 20.0,
                                  color: darkColor,
                                ),
                              ),
                            )
                          : const SizedBox(),
                    );
                  },
                ),
                bottomNavigationBar: const BottomNavigationbarDetail(),
                body: Builder(
                  builder: (context) {
                    return NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification notification) {
                        final currentOffset = (notification.metrics.pixels);
                        final offset =
                            TabbarDescReviewsDetail.offsetTabbarReview!.dy;
                        final bloc = context.read<ProductDetailUiCubit>();

                        bloc.changeShowFloatingAction(currentOffset > offset);

                        return true;
                      },
                      child: SafeArea(
                        child: SingleChildScrollView(
                          controller: controller,
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
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
