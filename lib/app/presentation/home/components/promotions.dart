import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/common/components/promotion.dart';

const double _maxHeightCardPromotion = 130.0;
const double _maxWidthCardPromotion = 280.0;

class PromotionList extends StatelessWidget {
  const PromotionList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
            child: ListTile(
              dense: true,
              minVerticalPadding: 0,
              contentPadding: EdgeInsets.zero,
              title: Text(
                AppLocalizations.of(context)!.promotions,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              trailing: InkWell(
                onTap: () => AppRoutes.router.push(Routes.PROMOTION),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.view_all,
                      style: PrimaryFont.instance.copyWith(
                        fontSize: 12.0,
                        color: primaryColor,
                      ),
                    ),
                    const Icon(Icons.arrow_right,
                        size: 25.0, color: primaryColor),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: _maxHeightCardPromotion,
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
                    cacheExtent: _maxHeightCardPromotion,
                    itemBuilder: (context, index) {
                      final promotion = promotions[index];

                      return LimitedBox(
                        maxWidth: _maxWidthCardPromotion,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * .75,
                          child: PromotionWidget(
                            promotion: promotion,
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
    );
  }
}
