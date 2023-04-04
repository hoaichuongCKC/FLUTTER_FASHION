import 'dart:developer';

import 'package:flutter_fashion/app/models/notification/notification_model.dart';
import 'package:flutter_fashion/utils/extensions/datetime.dart';

import '../../../../export.dart';

class ItemNotiNormal extends StatelessWidget {
  const ItemNotiNormal({super.key, required this.notification});

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        log("onTap");
      },
      onDoubleTap: () {
        log("onDoubleTap");
      },
      child: DecoratedBox(
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
          height: 100.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding - 6,
                vertical: verticalPadding - 6),
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
                        notification.title,
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
                            const WidgetSpan(child: SizedBox(width: 10)),
                            TextSpan(
                              text: notification.subtitle,
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
                            notification.created_at.formatDateTime(),
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
      ),
    );
  }
}
