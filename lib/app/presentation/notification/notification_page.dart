import 'package:flutter_fashion/app/blocs/cart/cart_cubit.dart';
import 'package:flutter_fashion/app/blocs/notification/notification_cubit.dart';
import 'package:flutter_fashion/app/blocs/user/user_cubit.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/app/presentation/notification/components/skeleton_noti.dart';
import 'package:flutter_fashion/common/components/app/background_app.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';
import '../../../export.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackgroundBlur.withAppBar(
      isHasBackground: false,
      title: AppLocalizations.of(context)!.notificationPage,
      actions: [
        InkWell(
          onTap: () => AppRoutes.router.push(Routes.CART),
          child: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              return state.whenOrNull(
                initial: () => const SizedBox(),
                loading: () => ColoredBox(
                  color: disableDarkColor.withOpacity(0.2),
                  child: const SizedBox(
                    width: 24.0,
                    height: 24.0,
                  ),
                ),
                fetchCompleted: (user) => SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/cart.svg",
                      ),
                      Positioned(
                        right: -3,
                        top: -5,
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                            color: errorColor,
                            shape: BoxShape.circle,
                          ),
                          child: SizedBox(
                            width: 15.0,
                            height: 15.0,
                            child: Center(
                              child: BlocBuilder<CartCubit, CartState>(
                                builder: (context, state) {
                                  return Text(
                                    state.items.length.toString(),
                                    style: PrimaryFont.instance.copyWith(
                                      fontSize: 9.0,
                                      color: lightColor,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )!;
            },
          ),
        ),
      ],
      child: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          final status = state.status;
          if (status == AppStatus.loading) {
            return const SkeletonNotification();
          }

          if (status == AppStatus.error) {
            return const Center(
              child: Text("SERVER ERROR"),
            );
          }

          final notifications = state.notificationsChat;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ColoredBox(
                  color: lightColor,
                  child: ListTile(
                    onTap: () => AppRoutes.router.pushNamed(
                      Names.NOTIFICATION_DETAIL,
                      queryParams: {
                        "name": "chat",
                      },
                    ),
                    leading: SvgPicture.asset(
                      "assets/icons/profile/messenger.svg",
                      width: 40.0,
                      height: 40.0,
                      fit: BoxFit.scaleDown,
                      colorFilter:
                          const ColorFilter.mode(primaryColor, BlendMode.srcIn),
                    ),
                    title: Text(
                      AppLocalizations.of(context)!.messenger,
                      style: PrimaryFont.instance.copyWith(
                        fontSize: 18.0,
                      ),
                    ),
                    trailing: SvgPicture.asset("assets/icons/arrow_right.svg"),
                    dense: true,
                    horizontalTitleGap: 0.0,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: horizontalPadding - 4),
                  ),
                ),
                const ColoredBox(
                  color: scaffoldBackgroundColor,
                  child: SizedBox(
                    height: 2.0,
                    width: double.infinity,
                  ),
                ),
                ColoredBox(
                  color: lightColor,
                  child: ListTile(
                    onTap: () => AppRoutes.router.pushNamed(
                      Names.NOTIFICATION_DETAIL,
                      queryParams: {
                        "name": "order",
                      },
                    ),
                    leading: SvgPicture.asset(
                      "assets/icons/profile/order.svg",
                      width: 40.0,
                      height: 40.0,
                      fit: BoxFit.scaleDown,
                      colorFilter:
                          const ColorFilter.mode(primaryColor, BlendMode.srcIn),
                    ),
                    title: Text(
                      AppLocalizations.of(context)!.my_order,
                      style: PrimaryFont.instance.copyWith(
                        fontSize: 18.0,
                      ),
                    ),
                    trailing: SvgPicture.asset("assets/icons/arrow_right.svg"),
                    dense: true,
                    horizontalTitleGap: 0.0,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: horizontalPadding - 4),
                  ),
                ),
                const ColoredBox(
                  color: scaffoldBackgroundColor,
                  child: SizedBox(
                    height: 2.0,
                    width: double.infinity,
                  ),
                ),
                ColoredBox(
                  color: lightColor,
                  child: ListTile(
                    onTap: () => AppRoutes.router.pushNamed(
                      Names.NOTIFICATION_DETAIL,
                      queryParams: {
                        "name": "daily",
                      },
                    ),
                    leading: SvgPicture.asset(
                      "assets/icons/notification.svg",
                      width: 40.0,
                      height: 40.0,
                      fit: BoxFit.scaleDown,
                      colorFilter:
                          const ColorFilter.mode(primaryColor, BlendMode.srcIn),
                    ),
                    title: Text(
                      AppLocalizations.of(context)!.daily,
                      style: PrimaryFont.instance.copyWith(
                        fontSize: 18.0,
                      ),
                    ),
                    trailing: SvgPicture.asset("assets/icons/arrow_right.svg"),
                    dense: true,
                    horizontalTitleGap: 0.0,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: horizontalPadding - 4),
                  ),
                ),
                // ListView.separated(
                //   separatorBuilder: (context, index) =>
                //       const SizedBox(height: 10.0),
                //   itemCount: notifications.length,
                //   shrinkWrap: true,
                //   cacheExtent: 120.0,
                //   physics: const NeverScrollableScrollPhysics(),
                //   itemBuilder: (context, index) {
                //     final notification = notifications[index];

                //     if (notification.order_id == null) {
                //       return ItemNotiNormal(notification: notification);
                //     }

                //     return ItemNotiOrder(notification: notification);
                //   },
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
