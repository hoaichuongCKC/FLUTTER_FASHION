import 'package:flutter_fashion/app/blocs/payment/payment.dart';
import 'package:flutter_fashion/app/blocs/payment/payment_state.dart';
import 'package:flutter_fashion/app/blocs/promotion/promotion_cubit.dart';
import 'package:flutter_fashion/app/models/promotion/promotion_model.dart';
import 'package:flutter_fashion/common/components/promotion.dart';

import '../../../../export.dart';
import 'package:flutter_fashion/app/blocs/cart/cart_cubit.dart';

class ListVoucherView extends StatelessWidget {
  const ListVoucherView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          minLeadingWidth: 0.0,
          leading: SvgPicture.asset(
            "assets/icons/voucher.svg",
            colorFilter: const ColorFilter.mode(
              secondaryColor,
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
        BlocBuilder<PaymentCubit, PaymentState>(
          buildWhen: (p, c) => p.promotion != c.promotion,
          builder: (context, state) {
            final bool isApplyPromotion = state.promotion != null;

            if (isApplyPromotion) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: !ThemeDataApp.instance.isLight
                      ? theme.cardColor
                      : successfullyColor.withAlpha(150),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(radiusBtn),
                  ),
                ),
                child: ListTile(
                  dense: true,
                  horizontalTitleGap: 0.0,
                  onTap: () => context.read<PaymentCubit>().cancelPromotion(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                  leading: const Icon(
                    Icons.check_circle,
                    size: 20.0,
                    color: lightColor,
                  ),
                  title: Text(
                    "Đã áp dụng khuyến mãi",
                    style:
                        theme.textTheme.bodySmall!.copyWith(color: lightColor),
                  ),
                  trailing: SvgPicture.asset(
                    "assets/icons/remove-circle.svg",
                    colorFilter: const ColorFilter.mode(
                      lightColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              );
            }

            return DecoratedBox(
              decoration: BoxDecoration(
                color: !ThemeDataApp.instance.isLight
                    ? theme.cardColor
                    : secondaryColor.withOpacity(0.2),
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
            );
          },
        ),
      ],
    );
  }

  void _showOptionPromotion(BuildContext context) async {
    final theme = Theme.of(context);
    final data = await showModalBottomSheet<PromotionModel?>(
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

        final cartBloc = context.watch<CartCubit>().state;

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
                        onPressed: () =>
                            AppRoutes.router.pop<PromotionModel?>(null),
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
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
                  cacheExtent: 150.0,
                  itemCount: promotionBloc.promotions.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 15.0),
                  itemBuilder: (context, index) {
                    final promotion = promotionBloc.promotions[index];
                    return SizedBox(
                      height: 150.0,
                      child: PromotionWidget(
                        promotion: promotion,
                        openSelected: true,
                        onSelected: (p0) => AppRoutes.router.pop(p0),
                        checkStatus: cartBloc.totalCart() >=
                            promotion.order_price_conditions,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
    if (data == null) return;

    // ignore: use_build_context_synchronously
    context.read<PaymentCubit>().checkPromotion(data, context);
  }
}
