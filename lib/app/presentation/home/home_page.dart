import 'package:flutter/rendering.dart';
import 'package:flutter_fashion/app/blocs/banner/banner_cubit.dart';
import 'package:flutter_fashion/app/blocs/category/category_cubit.dart';
import 'package:flutter_fashion/app/blocs/product/product_cubit.dart';
import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/presentation/home/components/banner.dart';
import 'package:flutter_fashion/app/presentation/home/components/popular_search.dart';
import 'package:flutter_fashion/app/presentation/home/components/product_categories.dart';
import 'package:flutter_fashion/app/presentation/home/components/product_recommend.dart';
import 'package:flutter_fashion/app/presentation/home/components/top_header.dart';
import 'package:flutter_fashion/app/presentation/login/export.dart';
import 'package:flutter_fashion/core/base/error/ui.dart';

import 'components/promotions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late BannerCubit _bannerCubit;
  late CategoryCubit _categoryCubit;
  late ProductCubit _productCubit;

  @override
  void initState() {
    super.initState();
    _bannerCubit = BlocProvider.of<BannerCubit>(context)..fetchData(context);
    _categoryCubit = BlocProvider.of<CategoryCubit>(context)..fetchData();
    _productCubit = BlocProvider.of<ProductCubit>(context)..fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: RefreshIndicator(
        onRefresh: () async {
          _bannerCubit.onRefresh();
          _categoryCubit.onRefresh();
          _productCubit.onRefresh();
        },
        child: CustomScrollView(
          slivers: [
            const TopHeaderHome(),
            BlocBuilder<BannerCubit, BannerState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox(),
                  loading: () => const BannerSkeletonHome(),
                  fetchCompleted: (dataList) =>
                      BannerHome(bannerList: dataList),
                  error: (error) => SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: horizontalPadding - 4),
                    sliver: SliverToBoxAdapter(
                      child: UIError(error: error),
                    ),
                  ),
                );
              },
            ),
            BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox(),
                  loading: () => const ProductCategoryLoadingHome(),
                  fetchCompleted: (dataList) =>
                      ProductCategoriesHome(categoryList: dataList),
                  error: (error) => SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: horizontalPadding - 4),
                    sliver: SliverToBoxAdapter(
                      child: UIError(error: error),
                    ),
                  ),
                );
              },
            ),
            const PopularSearchHome(),
            const PromotionList(),
            BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SliverToBoxAdapter(),
                  loading: () => const SliverToBoxAdapter(
                      child: CircularProgressIndicator()),
                  error: (String error) =>
                      SliverToBoxAdapter(child: Center(child: Text(error))),
                  fetchCompleted: (List<ProductModel> list) =>
                      ProductRecommend(listProduct: list),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
