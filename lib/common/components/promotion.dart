/// The PromotionWidget class is a custom painted widget that displays a promotion card with a teal
/// background.
import 'package:flutter_fashion/app/models/promotion/promotion_model.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import '../../config/svg_files.dart';

const double _maxHeightCardPromotion = 130.0;
const double _maxWidthCardPromotion = 280.0;

class PromotionWidget extends StatelessWidget {
  const PromotionWidget({
    super.key,
    required this.promotion,
    this.openSelected = false,
    this.onSelected,
    this.isAcceptSelect = false,
  });

  final PromotionModel promotion;

  final void Function(PromotionModel)? onSelected;

  final bool openSelected;

  final bool isAcceptSelect;
  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxWidth: _maxWidthCardPromotion,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .7,
        height: _maxHeightCardPromotion,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              Assets.voucherPNG,
              fit: BoxFit.cover,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 7,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '(${AppLocalizations.of(context)!.limit_turn_left(promotion.limit.toInt())})',
                                style: const TextStyle(
                                  fontSize: 8.0,
                                  color: lightColor,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Center(
                                child: Text(
                                  AppLocalizations.of(context)!.discount,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: lightColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                              Center(
                                child: Text(
                                  "${promotion.discount_price}%",
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    color: lightColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  promotion.name,
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    color: lightColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  promotion.desc,
                                  style: const TextStyle(
                                    fontSize: 10.0,
                                    color: lightColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 5, right: 8, bottom: 8, left: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.expired_date(
                            promotion.end_date.toString().substring(0, 10),
                          ),
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: blackColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(flex: 2),
                        !isAcceptSelect
                            ? const SizedBox()
                            : !openSelected
                                ? ColoredBox(
                                    color: primaryColor,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3.0, horizontal: 4.0),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .not_eligible,
                                        style: const TextStyle(
                                          fontSize: 8.0,
                                          color: lightColor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  )
                                : Flexible(
                                    flex: 2,
                                    child: ButtonWidget(
                                      onPressed: () => onSelected!(promotion),
                                      background: blackColor,
                                      child: Text(
                                        AppLocalizations.of(context)!.use,
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          color: lightColor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
