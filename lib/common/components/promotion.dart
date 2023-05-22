/// The PromotionWidget class is a custom painted widget that displays a promotion card with a teal
/// background.
import 'package:flutter_fashion/app/models/promotion/promotion_model.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/utils/extensions/datetime.dart';

class PromotionWidget extends StatelessWidget {
  static double _maxWidth = 0.0;

  static double _maxHeight = 0.0;

  const PromotionWidget({
    super.key,
    required this.promotion,
    this.colorBGLeft = lightColor,
    this.colorBGRight = lightColor,
    this.withPercent = 0.4,
    this.openSelected = false,
    this.checkStatus,
    this.onSelected,
  });

  final PromotionModel promotion;

  final void Function(PromotionModel)? onSelected;

  final Color colorBGLeft;

  final Color colorBGRight;

  final double withPercent;

  final bool openSelected;

  final bool? checkStatus;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        _maxWidth = constraints.biggest.width;
        _maxHeight = constraints.biggest.height;

        final flex = int.parse(withPercent.toString().substring(2));

        return CustomPaint(
          size: Size(_maxWidth, _maxHeight),
          painter: _PromotionCardPainter(
            colorBGLeft,
            colorBGRight,
            widthPercent: withPercent,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: flex,
                child: Container(
                  margin: EdgeInsets.all((_maxWidth * withPercent) * 0.1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.asset("assets/images/logo.png"),
                      ),
                      Text(
                        "OFF -${promotion.discount_price}%",
                        style: PrimaryFont.instance.copyWith(
                          fontSize: 14.0,
                          color: darkColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      openSelected
                          ? Text.rich(
                              TextSpan(
                                text: "Điều kiện: ",
                                children: [
                                  TextSpan(
                                    text: "đơn hàng đạt",
                                    style: PrimaryFont.instance.copyWith(
                                      fontSize: 8.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        " ${promotion.order_price_conditions.toVndCurrency()} ",
                                    style: PrimaryFont.instance.copyWith(
                                      fontSize: 8.0,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "trở lên",
                                    style: PrimaryFont.instance.copyWith(
                                      fontSize: 8.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                                style: PrimaryFont.instance.copyWith(
                                  fontSize: 8.0,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 10 - flex,
                child: Container(
                  margin: EdgeInsets.all((_maxWidth * withPercent) * 0.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          promotion.desc,
                          style: PrimaryFont.instance.copyWith(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w300,
                          ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      openSelected
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                checkStatus != null && !checkStatus!
                                    ? Container(
                                        padding: const EdgeInsets.all(3.0),
                                        color: errorColor.withAlpha(150),
                                        child: Text(
                                          "Không thể sử dụng",
                                          style: theme.bodySmall!.copyWith(
                                            color: lightColor,
                                            fontSize: 8.0,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        padding: const EdgeInsets.all(3.0),
                                        color: successfullyColor.withAlpha(200),
                                        child: Text(
                                          "Được sử dụng",
                                          style: theme.bodySmall!.copyWith(
                                            color: lightColor,
                                            fontSize: 8.0,
                                          ),
                                        ),
                                      ),
                                const SizedBox(width: 8.0),
                                checkStatus != null && !checkStatus!
                                    ? const SizedBox()
                                    : ButtonWidget(
                                        height: 30,
                                        width: 100,
                                        onPressed: () => onSelected!(promotion),
                                        child: Text(
                                          AppLocalizations.of(context)!.use,
                                          style: theme.bodySmall!
                                              .copyWith(color: lightColor),
                                        ),
                                      ),
                              ],
                            )
                          : Text(
                              AppLocalizations.of(context)!.expired_date(
                                  promotion.created_at.formatDateTime(
                                      isGetPM: false, isGetTime: false)),
                              style: PrimaryFont.instance.copyWith(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
