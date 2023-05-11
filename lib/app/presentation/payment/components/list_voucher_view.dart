import 'package:flutter_fashion/app/blocs/promotion/promotion_cubit.dart';
import 'package:flutter_fashion/common/components/promotion.dart';

import '../../../../export.dart';
import 'package:flutter_fashion/app/blocs/cart/cart_cubit.dart';

class ListVoucherView extends StatelessWidget {
  const ListVoucherView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartBloc = context.watch<CartCubit>().state;
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          minLeadingWidth: 0.0,
          leading: SvgPicture.asset(
            "assets/icons/voucher.svg",
            colorFilter: const ColorFilter.mode(
              primaryColor,
              BlendMode.srcIn,
            ),
          ),
          title: Text(
            AppLocalizations.of(context)!.promotions,
            style: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: !ThemeDataApp.instance.isLight
                ? theme.cardColor
                : disablePrimaryColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(radiusBtn),
            ),
          ),
          child: ListTile(
            dense: true,
            onTap: () => _showOptionPromotion(context),
            contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            title: Text(
              AppLocalizations.of(context)!.choose_a_promotion,
              style: theme.textTheme.bodySmall,
            ),
            trailing: Icon(
              Icons.touch_app_outlined,
              size: 18.0,
              color: theme.iconTheme.color!,
            ),
          ),
        ),
      ],
    );
  }

  void _showOptionPromotion(BuildContext context) async {
    final theme = Theme.of(context);
    final data = await showModalBottomSheet<String>(
      isScrollControlled: true,
      backgroundColor: lightColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radiusBtn / 2),
        topRight: Radius.circular(radiusBtn / 2),
      )),
      context: context,
      builder: (context) {
        final size = MediaQuery.of(context).size;

        final promotionBloc = context.watch<PromotionCubit>();
        return SizedBox(
          height: size.height * 0.85,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 45.0,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.promotions,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 5,
                      child: IconButton(
                        onPressed: () => AppRoutes.router.pop("String"),
                        icon: Icon(
                          Icons.clear,
                          size: theme.iconTheme.size,
                          color: theme.iconTheme.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  cacheExtent: 150.0,
                  itemCount: promotionBloc.promotions.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 15.0),
                  itemBuilder: (context, index) {
                    final promotion = promotionBloc.promotions[index];
                    return PromotionWidget(promotion: promotion);
                  },
                ),
              )
            ],
          ),
        );
      },
    );
    if (data == null) return;
  }
}
