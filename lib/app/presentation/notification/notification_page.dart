import 'package:flutter_fashion/app/blocs/notification/notification_cubit.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/app/presentation/notification/components/action_appbar.dart';
import 'package:flutter_fashion/app/presentation/notification/components/skeleton_noti.dart';
import 'package:flutter_fashion/common/components/app/background_app.dart';
import 'package:flutter_fashion/config/loadmore_data.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';
import 'package:flutter_fashion/utils/extensions/list.dart';

import 'components/item_noti_normal.dart';
import 'overylay_menu.dart';

class NotificationPage extends ScrollStateful {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends ScrollState<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return AppBackgroundBlur.withAppBar(
      onTap: () {
        MenuOverlay.instance.remove();
      },
      isHasBackground: false,
      leading: const SizedBox(),
      title: AppLocalizations.of(context)!.notificationPage,
      actions: const [
        ActionAppbarNotification(),
      ],
      child: BlocBuilder<NotificationCubit, NotificationState>(
        buildWhen: (p, c) =>
            c.notifications != p.notifications ||
            p.reads != c.reads ||
            p.status != c.status,
        builder: (context, state) {
          print("builder notificationCubit");
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

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(
                      horizontal: horizontalPadding - 4),
                  itemCount: state.notifications.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10.0),
                  itemBuilder: (context, index) {
                    bool isRead = true;
                    final notification = state.notifications[index];
                    if (state.reads.isEmpty) {
                      isRead = !isRead;
                    }

                    final isCheck = List<int>.from(state.reads)
                        .checkExistsId(state.reads, notification.id);

                    isRead = isCheck != -1;

                    return ItemNotiNormal(
                      notification: notification,
                      isRead: isRead,
                    );
                  },
                ),
              ),
              BlocBuilder<NotificationCubit, NotificationState>(
                buildWhen: (previous, current) =>
                    previous.isLoading != current.isLoading,
                builder: (context, state) {
                  if (!state.isLoading) {
                    return const SizedBox();
                  }
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        AppLocalizations.of(context)!.loading,
                        style: PrimaryFont.instance.copyWith(
                          fontSize: 14.0,
                          color: blackColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }

  @override
  void destroy(ScrollController controller) {
    scrollController.removeListener(
        () => context.read<NotificationCubit>().loadMore(controller));
  }

  @override
  void init() {}

  @override
  void scrollListen(ScrollController controller) {
    MenuOverlay.instance.remove();
    context.read<NotificationCubit>().loadMore(controller);
  }
}
