import 'package:flutter_fashion/app/blocs/cart/cart_cubit.dart';
import 'package:flutter_fashion/app/blocs/notification/notification_cubit.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/app/presentation/notification/components/skeleton_noti.dart';
import 'package:flutter_fashion/common/components/app/background_app.dart';
import 'package:flutter_fashion/config/notification.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';

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
            return Center(
              child: Text(
                "SERVER ERROR",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }

          final notificationChat = state.notificationsChat;
          final notificationDaily = state.notificationsDaily;
          final notificationOrder = state.notificationsOrder;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildListitle(
                  context,
                  iconPath: "assets/icons/profile/messenger.svg",
                  onTap: () => AppRoutes.router.push(
                    "${Routes.NOTIFICATION}/${Routes.NOTIFICATION_DETAIL}",
                    extra: {
                      "name": typeChat,
                    },
                  ),
                  subtitle: notificationChat.isEmpty
                      ? ""
                      : notificationChat[0].subtitle,
                  lengthReaded: state.chatDonotRead.length,
                  title: AppLocalizations.of(context)!.messenger,
                ),
                _buildDivider(context),
                _buildListitle(
                  context,
                  iconPath: "assets/icons/profile/order.svg",
                  onTap: () => AppRoutes.router.push(
                    "${Routes.NOTIFICATION}/${Routes.NOTIFICATION_DETAIL}",
                    extra: {
                      "name": typeOrder,
                    },
                  ),
                  subtitle: notificationOrder.isEmpty
                      ? ""
                      : notificationOrder[0].subtitle,
                  lengthReaded: state.orderDonotRead.length,
                  title: AppLocalizations.of(context)!.my_order,
                ),
                _buildDivider(context),
                _buildListitle(
                  context,
                  iconPath: "assets/icons/notification.svg",
                  onTap: () => AppRoutes.router.push(
                    "${Routes.NOTIFICATION}/${Routes.NOTIFICATION_DETAIL}",
                    extra: {
                      "name": typeDaily,
                    },
                  ),
                  subtitle: notificationDaily.isEmpty
                      ? ""
                      : notificationDaily[0].subtitle,
                  lengthReaded: state.dailyDonotRead.length,
                  title: AppLocalizations.of(context)!.daily,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).dividerColor,
      child: const SizedBox(
        height: 1.0,
        width: double.infinity,
      ),
    );
  }

  Widget _buildListitle(
    BuildContext context, {
    required String iconPath,
    required String title,
    String subtitle = "",
    int lengthReaded = 0,
    required VoidCallback onTap,
  }) {
    return ColoredBox(
      color: Theme.of(context).cardColor,
      child: ListTile(
        onTap: onTap,
        leading: SvgPicture.asset(
          iconPath,
          width: 40.0,
          height: 40.0,
          fit: BoxFit.scaleDown,
          colorFilter: const ColorFilter.mode(primaryColor, BlendMode.srcIn),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 14.0,
              ),
        ),
        subtitle: subtitle.isEmpty
            ? null
            : Text(
                AppLocalizations.of(context)!.a_new_message(subtitle),
                style: Theme.of(context).textTheme.bodySmall,
              ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            lengthReaded == 0
                ? const SizedBox()
                : DecoratedBox(
                    decoration: const BoxDecoration(
                        color: errorColor, shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        lengthReaded.toString(),
                        style: PrimaryFont.instance.copyWith(
                          fontSize: 10.0,
                          color: lightColor,
                        ),
                      ),
                    ),
                  ),
            lengthReaded == 0 ? const SizedBox() : const SizedBox(width: 3.0),
            SvgPicture.asset(
              "assets/icons/arrow_right.svg",
              colorFilter: ColorFilter.mode(
                Theme.of(context).iconTheme.color!,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
        dense: true,
        horizontalTitleGap: 6.0,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
      ),
    );
  }
}
