import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/presentation/modules/user/product_detail/components/app_bar_product_detail.dart';
import 'package:flutter_fashion/app/presentation/modules/user/product_detail/components/tabbar_desc_reviews.dart';
import 'package:flutter_fashion/app/presentation/modules/user/product_detail/cubit/product_detail_ui_cubit.dart';
import 'package:flutter_fashion/export.dart';

import 'components/body_product_detail.dart';
import 'components/botom_navigation_bar_detail.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final controller = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
                                  color: blackColor,
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
                    final bloc = context.read<ProductDetailUiCubit>();
                    bloc.selectImage(product.product_detail![0].color!, 0);
                    return NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification notification) {
                        final currentOffset = (notification.metrics.pixels);
                        final offset =
                            TabbarDescReviewsDetail.offsetTabbarReview!.dy;

                        bloc.changeShowFloatingAction(currentOffset > offset);

                        return true;
                      },
                      child: RefreshIndicator(
                        onRefresh: () async => context
                            .read<ReviewCubit>()
                            .onRefresh(product.id!, bloc),
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
