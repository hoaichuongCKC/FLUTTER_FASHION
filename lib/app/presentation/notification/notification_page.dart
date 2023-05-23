import 'package:flutter_fashion/app/blocs/notification/notification_cubit.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/app/presentation/notification/components/action_appbar.dart';
import 'package:flutter_fashion/app/presentation/notification/components/skeleton_noti.dart';
import 'package:flutter_fashion/common/components/app/background_app.dart';
import 'package:flutter_fashion/config/loadmore_data.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';

import 'components/item_noti_normal.dart';

class NotificationPage extends ScrollStateful {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends ScrollState<NotificationPage> {
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
        buildWhen: (p, c) =>
            p.isFirstLoad != c.isFirstLoad ||
            c.notifications != p.notifications,
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
                    final notification = state.notifications[index];
                    return ItemNotiNormal(
                      notification: notification,
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
                          color: textDisable,
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
    context.read<NotificationCubit>().loadMore(controller);
  }
}
