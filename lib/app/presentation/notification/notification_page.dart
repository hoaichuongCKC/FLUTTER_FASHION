import 'package:flutter_fashion/app/blocs/cart/cart_cubit.dart';
import 'package:flutter_fashion/app/blocs/notification/notification_cubit.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/app/presentation/notification/components/action_appbar.dart';
import 'package:flutter_fashion/app/presentation/notification/components/skeleton_noti.dart';
import 'package:flutter_fashion/common/components/app/background_app.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';

import 'components/item_noti_normal.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackgroundBlur.withAppBar(
      isHasBackground: false,
      leading: const SizedBox(),
      title: AppLocalizations.of(context)!.notificationPage,
      actions: const [
        ActionAppbarNotification(),
      ],
      child: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          final status = state.status;

          if (status == AppStatus.loading) {
            return const SkeletonNotification();
          }

          if (status == AppStatus.error) {
            return Center(
              child: Text(
                "SERVER ERROR",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }
          if (state.notifications.isEmpty) {
            return Center(
              child: Text(
                AppLocalizations.of(context)!.no_notifications,
              ),
            );
          }

          return ListView.separated(
            padding:
                const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
            itemCount: state.notifications.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10.0),
            itemBuilder: (context, index) {
              final notification = state.notifications[index];
              return ItemNotiNormal(
                notification: notification,
              );
            },
          );
        },
      ),
    );
  }
}
