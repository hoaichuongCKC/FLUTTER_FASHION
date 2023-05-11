import 'package:flutter_fashion/app/blocs/notification/notification_cubit.dart';
import 'package:flutter_fashion/app/models/notification/notification_model.dart';
import 'package:flutter_fashion/app/presentation/notification/components/item_noti_chat.dart';
import 'package:flutter_fashion/app/presentation/notification/components/item_noti_normal.dart';
import 'package:flutter_fashion/app/presentation/notification/components/item_noti_order.dart';
import 'package:flutter_fashion/config/notification.dart';
import 'package:flutter_fashion/export.dart';

import '../../../common/components/app/background_app.dart';

class NotificationDetailPage extends StatelessWidget {
  const NotificationDetailPage({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    List<NotificationModel> notifications = [];

    late int lengthNotiDoNotRead;

    final state = context.watch<NotificationCubit>().state;

    if (name == typeChat) {
      notifications = [...state.notificationsChat];

      lengthNotiDoNotRead = state.chatDonotRead.length;
    } else if (name == typeOrder) {
      lengthNotiDoNotRead = state.orderDonotRead.length;
      notifications = state.notificationsOrder;
    } else {
      lengthNotiDoNotRead = state.dailyDonotRead.length;
      notifications = state.notificationsDaily;
    }

    return AppBackgroundBlur.normal(
      title: AppLocalizations.of(context)!.notificationPage,
      actionsSecond: lengthNotiDoNotRead == 0
          ? null
          : [
              InkWell(
                onTap: () =>
                    context.read<NotificationCubit>().readAll(name, context),
                child: Text(
                  AppLocalizations.of(context)!.read_all(lengthNotiDoNotRead),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: primaryColor,
                      ),
                ),
              ),
            ],
      child: (notifications.isEmpty)
          ? Center(
              child: Text(
                AppLocalizations.of(context)!.no_notifications,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          : ListView.separated(
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 10.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];

                if (name == typeChat) {
                  return ItemNotiChat(notification: notification);
                }

                if (name == typeOrder) {
                  return ItemNotiOrder(notification: notification);
                }

                if (name == typeDaily) {
                  return ItemNotiNormal(notification: notification);
                }
                return const SizedBox();
              },
            ),
    );
  }
}
