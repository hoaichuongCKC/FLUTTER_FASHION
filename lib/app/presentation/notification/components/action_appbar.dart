import 'package:flutter_fashion/app/blocs/cart/cart_cubit.dart';
import 'package:flutter_fashion/app/blocs/notification/notification_cubit.dart';
import 'package:flutter_fashion/app/blocs/user/user_cubit.dart';
import 'package:flutter_fashion/export.dart';

class ActionAppbarNotification extends StatelessWidget {
  const ActionAppbarNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocSelector<NotificationCubit, NotificationState, bool>(
          selector: (state) {
            return state.reads.length == state.notifications.length;
          },
          builder: (context, state) {
            if (state) return const SizedBox();
            return InkWell(
              onTap: () {},
              borderRadius: const BorderRadius.all(
                Radius.circular(radiusBtn),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SvgPicture.asset("assets/icons/tick-double.svg"),
              ),
            );
          },
        ),
        const SizedBox(width: 5.0),
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
    );
  }
}
