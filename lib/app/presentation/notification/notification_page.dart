import 'package:flutter_fashion/app/blocs/cart/cart_cubit.dart';
import 'package:flutter_fashion/app/blocs/notification/notification_cubit.dart';
import 'package:flutter_fashion/app/blocs/user/user_cubit.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/app/presentation/notification/components/skeleton_noti.dart';
import 'package:flutter_fashion/common/components/app/background_app.dart';
import 'package:flutter_fashion/config/notification.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';
import '../../../export.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackgroundBlur.withAppBar(
      isHasBackground: false,
      leading: const SizedBox(),
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
                fetchCompleted: (user) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: Stack(
                      fit: StackFit.expand,
                      clipBehavior: Clip.none,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/cart.svg",
                          color: Theme.of(context).iconTheme.color,
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
                ),
              )!;
            },
          ),
        ),
      ],
      child: BlocBuilder<NotificationCubit, NotificationState>(
        buildWhen: (previous, current) {
          if (previous.isLoading != current.isLoading) {
            return false;
          }
          return true;
        },
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

          final notificationChat = state.notificationsChat;
          final notificationDaily = state.notificationsDaily;
          final notificationOrder = state.notificationsOrder;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ColoredBox(
                  color: lightColor,
                  child: ListTile(
                    onTap: () => AppRoutes.router.push(
                      "${Routes.NOTIFICATION}/${Routes.NOTIFICATION_DETAIL}",
                      extra: {
                        "name": typeChat,
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
                        fontSize: 16.0,
                      ),
                    ),
                    subtitle: notificationChat.isEmpty
                        ? null
                        : Text(
                            AppLocalizations.of(context)!
                                .a_new_message(notificationChat[0].subtitle),
                            style: PrimaryFont.instance.copyWith(
                              fontSize: 12.0,
                              color: disableDarkColor,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        state.chatDonotRead.isEmpty
                            ? const SizedBox()
                            : DecoratedBox(
                                decoration: const BoxDecoration(
                                    color: errorColor, shape: BoxShape.circle),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    state.chatDonotRead.length.toString(),
                                    style: PrimaryFont.instance.copyWith(
                                      fontSize: 12.0,
                                      color: lightColor,
                                    ),
                                  ),
                                ),
                              ),
                        state.chatDonotRead.isEmpty
                            ? const SizedBox()
                            : const SizedBox(width: 3.0),
                        SvgPicture.asset("assets/icons/arrow_right.svg"),
                      ],
                    ),
                    dense: true,
                    horizontalTitleGap: 6.0,
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
                    onTap: () => AppRoutes.router.push(
                      "${Routes.NOTIFICATION}/${Routes.NOTIFICATION_DETAIL}",
                      extra: {
                        "name": typeOrder,
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
                        fontSize: 16.0,
                      ),
                    ),
                    subtitle: notificationOrder.isEmpty
                        ? null
                        : Text(
                            AppLocalizations.of(context)!
                                .a_new_message(notificationOrder[0].subtitle),
                            style: PrimaryFont.instance.copyWith(
                              fontSize: 12.0,
                              color: disableDarkColor,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        state.orderDonotRead.isEmpty
                            ? const SizedBox()
                            : DecoratedBox(
                                decoration: const BoxDecoration(
                                    color: errorColor, shape: BoxShape.circle),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    state.orderDonotRead.length.toString(),
                                    style: PrimaryFont.instance.copyWith(
                                      fontSize: 12.0,
                                      color: lightColor,
                                    ),
                                  ),
                                ),
                              ),
                        state.orderDonotRead.isEmpty
                            ? const SizedBox()
                            : const SizedBox(width: 3.0),
                        SvgPicture.asset("assets/icons/arrow_right.svg"),
                      ],
                    ),
                    dense: true,
                    horizontalTitleGap: 6.0,
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
                    onTap: () => AppRoutes.router.push(
                      "${Routes.NOTIFICATION}/${Routes.NOTIFICATION_DETAIL}",
                      extra: {
                        "name": typeDaily,
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
                        fontSize: 16.0,
                      ),
                    ),
                    subtitle: notificationDaily.isEmpty
                        ? null
                        : Text(
                            AppLocalizations.of(context)!
                                .a_new_message(notificationDaily[0].subtitle),
                            style: PrimaryFont.instance.copyWith(
                              fontSize: 12.0,
                              color: disableDarkColor,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        state.dailyDonotRead.isEmpty
                            ? const SizedBox()
                            : DecoratedBox(
                                decoration: const BoxDecoration(
                                    color: errorColor, shape: BoxShape.circle),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    state.dailyDonotRead.length.toString(),
                                    style: PrimaryFont.instance.copyWith(
                                      fontSize: 12.0,
                                      color: lightColor,
                                    ),
                                  ),
                                ),
                              ),
                        state.dailyDonotRead.isEmpty
                            ? const SizedBox()
                            : const SizedBox(width: 3.0),
                        SvgPicture.asset("assets/icons/arrow_right.svg"),
                      ],
                    ),
                    dense: true,
                    horizontalTitleGap: 6.0,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: horizontalPadding - 4),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
