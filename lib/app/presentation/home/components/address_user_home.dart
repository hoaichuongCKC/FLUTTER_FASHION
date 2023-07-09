import 'package:flutter_fashion/app/blocs/address_user/address_user_cubit.dart';
import 'package:flutter_fashion/app/blocs/user/user_cubit.dart';
import 'package:flutter_fashion/config/svg_files.dart';
import 'package:flutter_fashion/export.dart';

class AddressUserHome extends StatelessWidget {
  const AddressUserHome({super.key});

  @override
  Widget build(BuildContext context) {
    final trailing = SvgPicture.asset(
      Assets.arrowRightSVG,
      colorFilter: ColorFilter.mode(
        Theme.of(context).iconTheme.color!,
        BlendMode.srcIn,
      ),
    );
    return SliverToBoxAdapter(
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox(),
            failure: (error) => const SizedBox(),
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

                    return ListTile(
                      dense: true,
                      onTap: () => AppRoutes.router.push(
                          "${Routes.PROFILE}/${Routes.ADDRESS_MANAGEMENT}"),
                      contentPadding: const EdgeInsets.fromLTRB(
                          horizontalPadding - 4,
                          0,
                          horizontalPadding - 4.0,
                          10),
                      leading: SvgPicture.asset(
                        Assets.mapAddressSVG,
                        width: 18.0,
                        height: 18.0,
                        fit: BoxFit.scaleDown,
                        colorFilter: const ColorFilter.mode(
                            secondaryColor, BlendMode.srcIn),
                      ),
                      horizontalTitleGap: 0.0,
                      title: Text(
                        address,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 14.0,
                            ),
                      ),
                      trailing: trailing,
                    );
                  }
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: horizontalPadding - 4),
                    padding: const EdgeInsets.symmetric(
                        horizontal: horizontalPadding - 4),
                    decoration: BoxDecoration(
                      color: disablePrimaryColor.withAlpha(80),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(radiusBtn / 2),
                      ),
                    ),
                    child: ListTile(
                      onTap: () => AppRoutes.router.push(
                          "${Routes.PROFILE}/${Routes.ADDRESS_MANAGEMENT}"),
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        AppLocalizations.of(context)!
                            .please_set_up_your_address,
                        style: Theme.of(context).textTheme.bodySmall!,
                      ),
                      trailing: trailing,
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
