import 'package:flutter_fashion/app/blocs/review/review_cubit.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/app/presentation/product_detail/export_detail.dart';
import 'package:flutter_fashion/utils/extensions/datetime.dart';

class TabbarDescReviewsDetail extends StatefulWidget {
  const TabbarDescReviewsDetail({super.key});

  @override
  State<TabbarDescReviewsDetail> createState() =>
      _TabbarDescReviewsDetailState();
}

class _TabbarDescReviewsDetailState extends State<TabbarDescReviewsDetail>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late ValueNotifier<int> _notifier;

  final int _length = 2;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _length, vsync: this);
    _notifier = ValueNotifier<int>(0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final detailInherited = ProductDetailInherited.of(context);

    final product = detailInherited.productModel;

    return DefaultTabController(
      length: _length,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Column(
          children: [
            TabBar(
              onTap: (index) {
                _notifier.value = index;
              },
              padding: EdgeInsets.zero,
              indicatorPadding: const EdgeInsets.symmetric(vertical: 5.0),
              controller: _tabController,
              dividerColor: Colors.transparent,
              labelPadding: const EdgeInsets.only(right: 8.0),
              labelStyle: PrimaryFont.instance.copyWith(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
              labelColor: darkColor,
              unselectedLabelColor: disableDarkColor,
              unselectedLabelStyle: PrimaryFont.instance.copyWith(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
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
                    style: PrimaryFont.instance.copyWith(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
                  );
                } else {
                  child = BlocBuilder<ReviewCubit, ReviewState>(
                    buildWhen: (previous, current) =>
                        previous.whenOrNull(
                          success: (reviews) => reviews,
                        ) !=
                        current.whenOrNull(
                          success: (reviews) => reviews,
                        ),
                    builder: (context, state) {
                      return state.when(
                        initial: () => const SizedBox(),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        failure: (e) => Text(e),
                        success: (reviews) => Column(
                          children: [
                            ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: reviews.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final review = reviews[index];

                                final checkImages = review.images == null ||
                                    review.images!.isEmpty;

                                Widget imageWidget = const SizedBox();

                                final contentWidget = Text(
                                  review.content!,
                                  style: PrimaryFont.instance.copyWith(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                );

                                if (!checkImages) {
                                  imageWidget = Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: LimitedBox(
                                      maxHeight: 70.0,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: review.images!
                                            .map(
                                              (e) => AspectRatio(
                                                aspectRatio: 1.0,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              radiusBtn)),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        ApiService.imageUrl +
                                                            e.photo,
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  );
                                }
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      dense: true,
                                      contentPadding: EdgeInsets.zero,
                                      leading: CircleAvatar(
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                          ApiService.imageUrl +
                                              review.user.photo,
                                        ),
                                      ),
                                      title: Text(review.user.username),
                                      subtitle: Text(
                                          review.created_at!.formatDateTime()),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            review.star.toString(),
                                            style:
                                                PrimaryFont.instance.copyWith(
                                              fontSize: 12.0,
                                            ),
                                          ),
                                          SvgPicture.asset(
                                              "assets/icons/star.svg"),
                                        ],
                                      ),
                                    ),
                                    imageWidget,
                                    contentWidget,
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      )!;
                    },
                  );
                }
                return child;
              },
            )
          ],
        ),
      ),
    );
  }
}
