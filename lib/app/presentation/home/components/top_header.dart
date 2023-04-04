import 'package:flutter_fashion/app/blocs/cart/cart_cubit.dart';
import 'package:flutter_fashion/app/blocs/user/user_cubit.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';

class TopHeaderHome extends StatelessWidget {
  const TopHeaderHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
          horizontal: horizontalPadding - 4, vertical: 15.0),
      sliver: SliverToBoxAdapter(
        child: SafeArea(
          child: ConstrainedBoxWidget(
            currentHeight: 0.2,
            maxHeight: 70,
            minHeight: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      return state.when(
                        failure: (error) => const SizedBox(),
                        initial: () => const SizedBox(),
                        loading: () => ColoredBox(
                          color: disableDarkColor.withOpacity(0.2),
                          child: const SizedBox(
                            height: 60.0,
                          ),
                        ),
                        fetchCompleted: (user) => Text(
                          '${AppLocalizations.of(context)!.wellcome}\n${user.fullName}!',
                          style: PrimaryFont.instance.copyWith(
                            fontSize: 22.0,
                            color: darkColor,
                          ),
                        ),
                      )!;
                    },
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () =>
                          AppRoutes.router.pushNamed(Routes.SEARCH),
                      icon: Hero(
                        tag: "icon-search",
                        transitionOnUserGestures: true,
                        child: SvgPicture.asset("assets/icons/search.svg"),
                      ),
                    ),
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
                                          child:
                                              BlocBuilder<CartCubit, CartState>(
                                            builder: (context, state) {
                                              return Text(
                                                state.items.length.toString(),
                                                style: PrimaryFont.instance
                                                    .copyWith(
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
