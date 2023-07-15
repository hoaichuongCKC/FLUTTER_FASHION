import 'package:flutter_fashion/common/components/app/background_app.dart';

import '../../../common/components/promotion.dart';
import '../../../export.dart';

const double _maxHeightCardPromotion = 130.0;

class PromotionPage extends StatelessWidget {
  const PromotionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final promotions = getIt.get<PromotionCubit>().promotions;

    return AppBackgroundBlur.normal(
      title: AppLocalizations.of(context)!.promotions,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
        itemCount: promotions.length,
        cacheExtent: _maxHeightCardPromotion,
        itemBuilder: (ctx, i) {
          final promotion = promotions[i];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: PromotionWidget(promotion: promotion),
          );
        },
      ),
    );
  }
}
