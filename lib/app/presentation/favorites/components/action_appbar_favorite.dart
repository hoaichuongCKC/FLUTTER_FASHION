import 'package:flutter_fashion/app/blocs/favorite/favorite_cubit.dart';
import 'package:flutter_fashion/app/presentation/notification/overylay_menu.dart';
import 'package:flutter_fashion/config/svg_files.dart';

import '../../../../export.dart';

class ActionAppBarFavorite extends StatelessWidget {
  const ActionAppBarFavorite({super.key});
  static GlobalKey keyOption = GlobalKey();
  @override
  Widget build(BuildContext context) {
    MenuOverlay.instance.remove();
    final theme = Theme.of(context);
    return BlocSelector<FavoriteCubit, FavoriteState, bool>(
      selector: (state) {
        return state.listProduct.isEmpty;
      },
      builder: (context, isEmpty) {
        if (isEmpty) {
          return const SizedBox();
        }

        return BlocBuilder<FavoriteCubit, FavoriteState>(
          buildWhen: (p, c) =>
              p.isShowCheckBox != c.isShowCheckBox ||
              p.chooseItemsDelete != c.chooseItemsDelete,
          builder: (context, state) {
            if (state.isShowCheckBox) {
              return Text.rich(
                TextSpan(
                  text: "${AppLocalizations.of(context)!.selected}: ",
                  style: theme.textTheme.bodySmall!,
                  children: [
                    TextSpan(
                      text: state.chooseItemsDelete.length.toString(),
                      style: theme.textTheme.bodySmall!,
                    ),
                  ],
                ),
              );
            }
            return InkWell(
              onTap: () {
                // final notificationCubit =
                //     BlocProvider.of<NotificationCubit>(context);

                // final quantity = notificationCubit.state.notifications.length -
                //     notificationCubit.state.reads.length;
                MenuOverlay.instance.showOverlay(
                  context,
                  key: keyOption,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        onTap: () {
                          context.read<FavoriteCubit>().showCheckBox();
                          MenuOverlay.instance.remove();
                        },
                        title: Text(
                          AppLocalizations.of(context)!.edit,
                          style: const TextStyle(
                            color: blackColor,
                          ),
                        ),
                        dense: true,
                      ),
                      ListTile(
                        onTap: () {
                          context.read<FavoriteCubit>().removeAll();
                          MenuOverlay.instance.remove();
                        },
                        title: Text(
                          AppLocalizations.of(context)!.delete_all,
                          style: const TextStyle(
                            color: blackColor,
                          ),
                        ),
                        dense: true,
                      ),
                    ],
                  ),
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
            );
          },
        );
      },
    );
  }
}
