import 'package:flutter_fashion/app/blocs/cart/cart_cubit.dart';
import 'package:flutter_fashion/app/blocs/notification/notification_cubit.dart';
import 'package:flutter_fashion/app/blocs/user/user_cubit.dart';
import 'package:flutter_fashion/config/svg_files.dart';
import 'package:flutter_fashion/export.dart';

import '../overylay_menu.dart';

class ActionAppbarNotification extends StatelessWidget {
  const ActionAppbarNotification({super.key});

  static GlobalKey keyOption = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
                          Assets.cartSVG,
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
        const SizedBox(width: 5.0),
        InkWell(
          onTap: () {
            final notificationCubit =
                BlocProvider.of<NotificationCubit>(context);

            final quantity = notificationCubit.state.notifications.length -
                notificationCubit.state.reads.length;
            MenuOverlay.instance.showOverlay(
              context,
              key: keyOption,
              child: child(context, quantity),
            );
          },
          borderRadius: const BorderRadius.all(
            Radius.circular(radiusBtn),
          ),
          child: Padding(
            key: keyOption,
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(Assets.moreVerticalSVG),
          ),
        ),
      ],
    );
  }

  Widget child(BuildContext context, quantity) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            onTap: () {
              context.read<NotificationCubit>().readAll();
              MenuOverlay.instance.remove();
            },
            title: Text(
              AppLocalizations.of(context)!.read_all(quantity),
              style: const TextStyle(
                color: blackColor,
              ),
            ),
            dense: true,
          ),
          ListTile(
            onTap: () {
              context.read<NotificationCubit>().deleteAll();
              MenuOverlay.instance.remove();
            },
            title: Text(
              AppLocalizations.of(context)!.delete_all,
              style: const TextStyle(
                color: blackColor,
              ),
            ),
            dense: true,
          )
        ],
      );
}
