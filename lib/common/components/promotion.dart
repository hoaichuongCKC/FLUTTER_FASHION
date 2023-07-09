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
                                  promotion.desc,
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    color: lightColor,
                                    fontWeight: FontWeight.w500,
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

class _PromotionCardPainter extends CustomPainter {
  const _PromotionCardPainter(this._backgroundLeft, this._backgroundRight,
      {this.widthPercent = 0.4});

  final Color _backgroundLeft;
  final Color _backgroundRight;
  final double widthPercent;
  @override
  void paint(Canvas canvas, Size size) {
    // init paint image left
    var paint = Paint()
      ..color = _backgroundLeft
      ..strokeCap = StrokeCap.butt
      ..strokeWidth = 5.0
      ..style = PaintingStyle.fill;

    final double maxWidthBGLeft = size.width * widthPercent; // 40% of _maxWidth

    _drawBgLeft(canvas, paint, maxWidthBGLeft, size);

    _drawBgRight(canvas, paint..color = _backgroundRight, maxWidthBGLeft, size);
  }

  void _drawBgLeft(
      Canvas canvas, Paint paint, double maxWidthBGLeft, Size size) {
    Path path = Path();
    //Start Top Left to Top Right
    final Offset start =
        Offset(maxWidthBGLeft * .1, size.height * 0); // 10% width and 0 height

    final Offset end = Offset(maxWidthBGLeft - maxWidthBGLeft * .1,
        size.height * 0); // 40% - 10% width and 0 height

    path.moveTo(start.dx, start.dy);

    path.lineTo(end.dx, end.dy); //p0
    //p0 (40% -5%, 0), p1(40% - 10%, 8%), p2(40%,8%)

    path.quadraticBezierTo(
      maxWidthBGLeft - maxWidthBGLeft * 0.1,
      size.height * 0.08, // 8% height
      maxWidthBGLeft,
      size.height * 0.08, // 8% height
    );

    path.lineTo(maxWidthBGLeft, size.height * .92); // p0
    //p0 (40%, 92%), p1(40% - 10%, 92%), p2(40% - 10%, maxHeight)

    path.quadraticBezierTo(
      end.dx,
      size.height * .92,
      maxWidthBGLeft - maxWidthBGLeft * .1,
      size.height,
    );

    path.lineTo(start.dx, size.height); //p0

    //p0 (5%, maxHeight%), p1(5%, 92%), p2(0%, 92%)

    path.quadraticBezierTo(
      start.dx,
      size.height * .92,
      start.dx * 0,
      size.height * .92,
    );

    path.lineTo(start.dx * 0, size.height * .08); //p0
    //p0 (0%, 8%), p1(10%, 8%), p2(10%, 0%)
    path.quadraticBezierTo(
      start.dx,
      size.height * .08,
      start.dx,
      size.height * .0,
    );
    canvas.drawPath(path, paint);

    path.close();
  }

  void _drawBgRight(
      Canvas canvas, Paint paint, double maxWidthBGLeft, Size size) {
    Path path = Path();

    //Start Top Left to Top Right
    final Offset start = Offset(maxWidthBGLeft + maxWidthBGLeft * .1,
        size.height * 0); // 40% +10% width and 0 height

    final Offset end = Offset(size.width - maxWidthBGLeft * .1,
        size.height * 0); // 100% - 10% of 40% width and 0 height

    path.moveTo(start.dx, start.dy); //40% + 10% of 40%

    path.lineTo(end.dx, start.dy); //p0 // 100% - 10% of 40% width and 0 height
    //p0 (100% -10%,0), p1 (100% -10%, 8%), p2 (100%,8%)
    path.quadraticBezierTo(
      end.dx,
      size.height * 0.08, // 8% height
      size.width,
      size.height * 0.08, // 8% height
    );

    path.lineTo(size.width,
        size.height * .92); //p0 // 100% - 10% of 40% width and 92% height

    //p0 (100% -10%, 92%), p1 (100% -10%, 92%), p2 (100% - 10%, 100%)
    path.quadraticBezierTo(
      end.dx,
      size.height * .92,
      end.dx,
      size.height,
    );

    path.lineTo(start.dx, size.height); //p0 //  40% +10% width and 100% height

    //p0 (40+10%, 100%), p1 (40% + 10%, 92%), p2 (40% -10%, 92%)
    path.quadraticBezierTo(
      start.dx, // p1 x
      size.height * .92, //p1 y
      start.dx - maxWidthBGLeft * .1, // p2
      size.height * .92, // p2
    );

    path.lineTo(start.dx - maxWidthBGLeft * .1,
        size.height * .08); //p0 //  40% - 10% width and 8% height

    //p0 (40- 10%, 8%), p1 (40% + 10%, 8%), p2 (40% - 10%, 0%)
    path.quadraticBezierTo(
      start.dx, // p1 x
      size.height * .08, //p1 y
      start.dx, // p2
      size.height * .0, // p2
    );
    canvas.drawPath(path, paint);

    path.close();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
