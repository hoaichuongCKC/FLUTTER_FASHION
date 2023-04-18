import 'package:flutter_fashion/common/components/app/background_app.dart';

import '../../../export.dart';

class PromotionPage extends StatelessWidget {
  const PromotionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackgroundBlur.withAppBar(
      title: AppLocalizations.of(context)!.promotions,
      child: Column(
        children: [],
      ),
    );
  }
}
