import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/config/svg_files.dart';

import '../../../../common/components/promotion.dart';

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
          const SizedBox(height: 30),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
            child: ListTile(
              dense: true,
              minVerticalPadding: 0,
              contentPadding: EdgeInsets.zero,
              title: Text(
                AppLocalizations.of(context)!.promotions,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
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
                    itemCount: promotions.length + 1,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: horizontalPadding - 4),
                    cacheExtent: _maxHeightCardPromotion,
                    itemBuilder: (context, index) {
                      if (index == promotions.length) {
                        return InkWell(
                          onTap: () {
                            AppRoutes.router.pushNamed(Names.PROMOTION);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              DecoratedBox(
                                decoration: const BoxDecoration(
                                  color: lightColor,
                                  shape: BoxShape.circle,
                                ),
                                child: SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: SvgPicture.asset(
                                    Assets.allSVG,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                AppLocalizations.of(context)!.view_all,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontSize: 12.0),
                              ),
                            ],
                          ),
                        );
                      }

                      final promotion = promotions[index];

                      return PromotionWidget(promotion: promotion);
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
