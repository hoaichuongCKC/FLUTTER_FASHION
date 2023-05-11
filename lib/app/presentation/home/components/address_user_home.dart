import 'package:flutter_fashion/app/blocs/address_user/address_user_cubit.dart';
import 'package:flutter_fashion/app/blocs/user/user_cubit.dart';
import 'package:flutter_fashion/export.dart';

class AddressUserHome extends StatelessWidget {
  const AddressUserHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ListTile(
        dense: true,
        onTap: () => AppRoutes.router
            .push("${Routes.PROFILE}/${Routes.ADDRESS_MANAGEMENT}"),
        contentPadding: const EdgeInsets.fromLTRB(
            horizontalPadding - 4, 0, horizontalPadding - 4.0, 10),
        leading: SvgPicture.asset(
          "assets/icons/map_address.svg",
          width: 24.0,
          height: 24.0,
          fit: BoxFit.cover,
          colorFilter: const ColorFilter.mode(primaryColor, BlendMode.srcIn),
        ),
        horizontalTitleGap: 0.0,
        title: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox(),
              loading: () => ColoredBox(
                color: skeletonColor,
                child: const SizedBox(
                  height: 35.0,
                  width: double.infinity,
                ),
              ),
              fetchCompleted: (user) {
                return BlocBuilder<AddressUserCubit, AddressUserState>(
                  builder: (context, state) {
                    final isCheckAddress = state.usingAddress.isNotEmpty;
                    if (isCheckAddress) {
                      final address = state.usingAddress[0].name;
                      return Text(
                        address,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 14.0,
                            ),
                      );
                    }
                    return ColoredBox(
                      color: ThemeDataApp.instance.isLight
                          ? warningColor.withOpacity(0.2)
                          : Colors.teal,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          AppLocalizations.of(context)!.update_your_address,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 14.0,
                                  ),
                        ),
                      ),
                    );
                  },
                );
              },
              failure: (e) => Text(e),
            );
          },
        ),
        trailing: SvgPicture.asset(
          "assets/icons/arrow_right.svg",
          colorFilter: ColorFilter.mode(
            Theme.of(context).iconTheme.color!,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
