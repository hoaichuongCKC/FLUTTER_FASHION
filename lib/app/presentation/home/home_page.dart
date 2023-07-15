import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/presentation/home/components/product_new_month.dart';
import 'package:flutter_fashion/app/presentation/home/components/product_sale_area.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/config/loadmore_data.dart';

class HomePage extends ScrollStateful {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ScrollState<HomePage> {
  @override
  void scrollListen(ScrollController controller) {
    getIt.get<LoadMoreProductBloc>().handleScrollNotification(controller);
  }

  @override
  void destroy(ScrollController controller) {
    controller.removeListener(() =>
        getIt.get<LoadMoreProductBloc>().handleScrollNotification(controller));
  }

  @override
  void init() {
    context.read<UserCubit>().fetchUser();
    context.read<BannerCubit>().fetchData(context);
    context.read<CategoryCubit>().fetchData();
    context.read<ProductCubit>().fetchData();
    context.read<PopularProductCubit>().fetchData();
    context.read<PromotionCubit>().fetchPromotion();
    context.read<ProductNewCubit>().fetchData();
    context.read<ProductSaleCubit>().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<BannerCubit>().onRefresh(context);
          context.read<CategoryCubit>().onRefresh();
          context.read<ProductCubit>().onRefresh();
          context.read<PopularProductCubit>().onRefresh();
          context.read<PromotionCubit>().onRefresh();
          context.read<ProductNewCubit>().onRefresh();
        },
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            const TopHeaderHome(),
            const AddressUserHome(),
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
            BlocBuilder<ProductSaleCubit, ProductSaleState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox(),
                  loading: () => const SkeletonNewProductHome(),
                  success: (products) {
                    if (products.isEmpty) return const SliverToBoxAdapter();
                    return ProductSaleArea(products: products);
                  },
                  failure: (e) => Text(e),
                );
              },
            ),
            BlocBuilder<ProductNewCubit, ProductNewState>(
              builder: (context, state) {
                return state.when(
                    initial: () => const SliverToBoxAdapter(),
                    loading: () => const SkeletonNewProductHome(),
                    failure: (String error) =>
                        SliverToBoxAdapter(child: Text(error)),
                    success: (List<ProductModel> products) {
                      if (products.isEmpty) return const SliverToBoxAdapter();
                      return ProductNewMonth(products: products);
                    });
              },
            ),
            BlocBuilder<PopularProductCubit, PopularSearchState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SliverToBoxAdapter(),
                  loading: () => const SliverToBoxAdapter(
                    child: PopularSkeleton(),
                  ),
                  error: (String error) => SliverToBoxAdapter(
                    child: Center(
                        child: SizedBox(height: 200, child: Text(error))),
                  ),
                  fetchCompleted: (List<ProductModel> list) {
                    if (list.isEmpty) {
                      return const SliverToBoxAdapter();
                    }
                    return PopularHome(listProduct: list);
                  },
                );
              },
            ),
            const PromotionList(),
            BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SliverToBoxAdapter(),
                  loading: () => const SliverToBoxAdapter(
                    child: SkeletonGridView(),
                  ),
                  error: (String error) =>
                      SliverToBoxAdapter(child: Center(child: Text(error))),
                  fetchCompleted: (List<ProductModel> list) => ProductRecommend(
                    listProduct: list,
                  ),
                );
              },
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 15)),
            StreamBuilder<bool>(
              stream: getIt<LoadMoreProductBloc>().isLoading,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SliverToBoxAdapter();
                }
                if (snapshot.data!) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.loading,
                        style: PrimaryFont.instance.copyWith(
                          fontSize: 14.0,
                          color: textDisable,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  );
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
