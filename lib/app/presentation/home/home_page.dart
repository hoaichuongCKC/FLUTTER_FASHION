import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(
        () {
          getIt
              .get<LoadMoreProductBloc>()
              .handleScrollNotification(_scrollController, context);
        },
      );
    context.read<UserCubit>().fetchUser();
    context.read<BannerCubit>().fetchData(context);
    context.read<CategoryCubit>().fetchData();
    context.read<ProductCubit>().fetchData();
    context.read<PopularSearchCubit>().fetchData();
    context.read<PromotionCubit>().fetchPromotion(null);
  }

  @override
  void dispose() {
    _scrollController.removeListener(() => getIt
        .get<LoadMoreProductBloc>()
        .handleScrollNotification(_scrollController, context));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<BannerCubit>().onRefresh(context);
          context.read<CategoryCubit>().onRefresh();
          context.read<ProductCubit>().onRefresh();
          context.read<PopularSearchCubit>().onRefresh();
          context.read<PromotionCubit>().onRefresh();
        },
        child: CustomScrollView(
          controller: _scrollController,
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
            const SaleAreaHome(),
            BlocBuilder<PopularSearchCubit, PopularSearchState>(
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
                  fetchCompleted: (List<ProductModel> list) => PopularHome(
                    listProduct: list,
                  ),
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
                          fontSize: 12.0,
                          color: primaryColor,
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
