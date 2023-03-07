import 'package:flutter_fashion/app/blocs/banner/banner_cubit.dart';
import 'package:flutter_fashion/app/blocs/category/category_cubit.dart';
import 'package:flutter_fashion/app/blocs/product/product_cubit.dart';
import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/presentation/home/components/banner.dart';
import 'package:flutter_fashion/app/presentation/home/components/popular_search.dart';
import 'package:flutter_fashion/app/presentation/home/components/product_categories.dart';
import 'package:flutter_fashion/app/presentation/home/components/product_recommend.dart';
import 'package:flutter_fashion/app/presentation/home/components/top_header.dart';
import 'package:flutter_fashion/app/presentation/home/blocs/loadmore_bloc.dart';
import 'package:flutter_fashion/app/presentation/login/export.dart';
import 'package:flutter_fashion/common/components/item_product.dart';
import 'package:flutter_fashion/core/base/error/ui.dart';

import 'components/promotions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  late LoadMoreProductBloc _loadMoreProductController;

  @override
  void initState() {
    _loadMoreProductController = LoadMoreProductBloc();
    _scrollController = ScrollController()
      ..addListener(() {
        _loadMoreProductController.handleScrollNotification(_scrollController);
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(() =>
        _loadMoreProductController.handleScrollNotification(_scrollController));
    _loadMoreProductController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<BannerCubit>().onRefresh();
          context.read<CategoryCubit>().onRefresh();
          context.read<ProductCubit>().onRefresh();
        },
        child: CustomScrollView(
          controller: _scrollController,
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
                    child: ItemProductSkeleton(),
                  ),
                  error: (String error) =>
                      SliverToBoxAdapter(child: Center(child: Text(error))),
                  fetchCompleted: (List<ProductModel> list) => ProductRecommend(
                      listProduct: list,
                      loadMoreProductbloc: _loadMoreProductController),
                );
              },
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 15)),
            StreamBuilder(
              stream: _loadMoreProductController.isLoading,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SliverToBoxAdapter();
                }
                if (snapshot.data!) {
                  return const SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()));
                }
                return const SliverToBoxAdapter();
              },
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 15)),
          ],
        ),
      ),
    );
  }
}
