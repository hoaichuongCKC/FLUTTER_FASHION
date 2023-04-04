import 'package:flutter_fashion/app/models/notification/notification_model.dart';

import '../../../../export.dart';

class ItemNotiOrder extends StatelessWidget {
  const ItemNotiOrder({super.key, required this.notification});

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: lightColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),
        ),
        boxShadow: [
          BoxShadow(
            color: darkColor.withOpacity(0.2),
            blurRadius: 7.0,
          ),
        ],
      ),
      child: SizedBox(
        height: 115.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: horizontalPadding - 4, vertical: verticalPadding - 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.cover,
                  width: 70,
                  height: 70,
                ),
              ),
              const SizedBox(width: 8.0),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Bạn đang có đơn đang trên đường giao',
                      style: PrimaryFont.instance.copyWith(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10.0),
                    Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            child: Image.asset(
                              "assets/images/loudspeaker.png",
                              fit: BoxFit.scaleDown,
                              width: 20,
                              height: 20,
                            ),
                          ),
                          TextSpan(
                            text: ' Nhân viên: ',
                            style: PrimaryFont.instance.copyWith(
                              fontSize: 12.0,
                              color: primaryColor,
                            ),
                          ),
                          TextSpan(
                            text:
                                'đơn hàng của bạn đang vận chuyển tới địa điểm. Xin lui chú ý! nhessadasd',
                            style: PrimaryFont.instance.copyWith(
                              fontSize: 12.0,
                              color: darkColor.withOpacity(0.6),
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/calendar.svg",
                          width: 18.0,
                          height: 18.0,
                          colorFilter: const ColorFilter.mode(
                              primaryColor, BlendMode.srcIn),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          '10:30 20-01-2023',
                          style: PrimaryFont.instance.copyWith(
                            fontSize: 12.0,
                            color: darkColor.withOpacity(0.6),
                            fontWeight: FontWeight.w300,
                          ),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
