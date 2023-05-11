import 'package:flutter_fashion/app/blocs/review/review_cubit.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/app/presentation/product_detail/cubit/product_detail_ui_cubit.dart';
import 'package:flutter_fashion/app/presentation/product_detail/export_detail.dart';
import 'package:flutter_fashion/common/components/chart_review_cpn.dart';
import 'package:flutter_fashion/common/components/review_list.dart';

class TabbarDescReviewsDetail extends StatefulWidget {
  const TabbarDescReviewsDetail({super.key});
  static GlobalKey tabbarReviewKey = GlobalKey();
  static Offset? get offsetTabbarReview {
    final render =
        tabbarReviewKey.currentContext!.findRenderObject() as RenderBox;
    final offset = render.localToGlobal(Offset.zero);
    return offset;
  }

  @override
  State<TabbarDescReviewsDetail> createState() =>
      _TabbarDescReviewsDetailState();
}

class _TabbarDescReviewsDetailState extends State<TabbarDescReviewsDetail>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late ValueNotifier<int> _notifier;

  final int _length = 2;

  late ReviewCubit blocFist;

  late ProductDetailUiCubit blocSecond;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _length, vsync: this);

    _notifier = ValueNotifier<int>(0);

    blocSecond = BlocProvider.of<ProductDetailUiCubit>(context);

    blocFist = BlocProvider.of<ReviewCubit>(context);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ProductModel product =
        InheritedDataApp.of<ProductModel>(context)!.data;

    blocFist.fetchData(product.id!, blocSecond);

    final theme = Theme.of(context);

    final bloc = context.read<ReviewCubit>();

    return DefaultTabController(
      length: _length,
      child: Column(
        children: [
          TabBar(
            key: TabbarDescReviewsDetail.tabbarReviewKey,
            onTap: (index) {
              _notifier.value = index;
            },
            padding: EdgeInsets.zero,
            indicatorPadding: const EdgeInsets.symmetric(vertical: 5.0),
            controller: _tabController,
            dividerColor: Colors.transparent,
            labelPadding: const EdgeInsets.only(right: 8.0),
            labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
            labelColor: Theme.of(context).textTheme.bodyMedium!.color,
            unselectedLabelColor: Theme.of(context).textTheme.bodyMedium!.color,
            unselectedLabelStyle:
                Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                text: AppLocalizations.of(context)!.desc,
              ),
              Tab(text: AppLocalizations.of(context)!.review),
            ],
          ),
          ValueListenableBuilder<int>(
            valueListenable: _notifier,
            child: const SizedBox(),
            builder: (context, index, child) {
              if (index == 0) {
                child = Text(
                  product.desc!,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                );
              } else {
                child = BlocBuilder<ReviewCubit, ReviewState>(
                  buildWhen: (p, c) =>
                      p.maybeWhen(
                        orElse: () => true,
                        success: (value) => value.reviews,
                      ) !=
                      c.maybeWhen(
                        orElse: () => true,
                        success: (value) => value.reviews,
                      ),
                  builder: (context, state) {
                    return state.when(
                      initial: () => const SizedBox(),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      failure: (e) => Text(e),
                      success: (data) {
                        if (data.reviews.isEmpty) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: Image.asset(
                                  "assets/images/review_empty.png",
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Text(
                                'No Reviews',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          );
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ChartReviewCpn(data: data),
                            const Divider(),
                            ReviewListCpn(reviews: data.reviews),
                            BlocBuilder<ProductDetailUiCubit,
                                ProductDetailUiState>(
                              buildWhen: (p, c) =>
                                  p.hasLoadMore != c.hasLoadMore,
                              builder: (context, state) {
                                if (state.hasLoadMore) {
                                  return Align(
                                    child: InkWell(
                                      onTap: () =>
                                          bloc.loadMore(product.id!, context),
                                      radius: radiusBtn,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(radiusBtn),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Hiển thị thêm',
                                          style: theme.textTheme.bodySmall!
                                              .copyWith(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w800,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return const SizedBox();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              }
              return child;
            },
          )
        ],
      ),
    );
  }
}
