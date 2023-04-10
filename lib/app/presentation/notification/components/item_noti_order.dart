import 'package:flutter_fashion/app/blocs/notification/notification_cubit.dart';
import 'package:flutter_fashion/app/models/notification/notification_model.dart';
import 'package:flutter_fashion/config/notification.dart';
import 'package:flutter_fashion/utils/extensions/datetime.dart';

import '../../../../export.dart';

class ItemNotiOrder extends StatelessWidget {
  const ItemNotiOrder({super.key, required this.notification});

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        notification.is_read == 1 ? lightColor : darkColor.withOpacity(0.05);
    return InkWell(
      onTap: () {
        if (notification.is_read == 0) {
          context
              .read<NotificationCubit>()
              .readNotiLocal(notification.id, typeOrder, context);
        }
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: ConstrainedBoxWidget(
          currentHeight: 0.15,
          maxHeight: 110,
          minHeight: 90.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding - 4,
                vertical: verticalPadding - 4),
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
                Flexible(
                  flex: 1,
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
                      const SizedBox(height: 8.0),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              WidgetSpan(
                                child: Image.asset(
                                  "assets/images/loudspeaker.png",
                                  fit: BoxFit.scaleDown,
                                  width: 18,
                                  height: 18,
                                ),
                              ),
                              const WidgetSpan(child: SizedBox(width: 6.0)),
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
