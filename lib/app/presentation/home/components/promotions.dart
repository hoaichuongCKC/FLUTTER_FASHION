import 'package:flutter_fashion/app/blocs/promotion/promotion_cubit.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';

class PromotionList extends StatelessWidget {
  const PromotionList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: verticalPadding + 1),
      sliver: SliverToBoxAdapter(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
              child: Text(
                AppLocalizations.of(context)!.promotions,
                style: PrimaryFont.instance.large(),
              ),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              height: 120.0,
              child: BlocBuilder<PromotionCubit, PromotionState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const SizedBox(),
                    loading: () => const SizedBox(),
                    success: (promotions) => ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 15.0),
                      itemCount: promotions.length,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                          horizontal: horizontalPadding - 4),
                      cacheExtent: 120.0,
                      itemBuilder: (context, index) {
                        final promotion = promotions[index];
                        return LimitedBox(
                          maxWidth: 280.0,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * .75,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: lightColor,
                                border: Border.all(color: primaryColor),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(radiusBtn),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/images/logo.png",
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.scaleDown,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Giảm ${promotion.discount_price}%",
                                                  style: PrimaryFont.instance
                                                      .copyWith(
                                                    fontSize: 14.0,
                                                    color: primaryColor,
                                                  ),
                                                ),
                                                Text(
                                                  promotion.desc,
                                                  style: PrimaryFont.instance
                                                      .copyWith(
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            AppLocalizations.of(context)!
                                                .expired_date(
                                              promotion.end_date
                                                  .toString()
                                                  .substring(0, 10),
                                            ),
                                            style:
                                                PrimaryFont.instance.copyWith(
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    failure: (e) => Text(
                      e,
                      style: PrimaryFont.instance.copyWith(
                        fontSize: 14.0,
                        color: errorColor,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
