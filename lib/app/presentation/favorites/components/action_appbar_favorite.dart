import 'package:flutter_fashion/app/blocs/favorite/favorite_cubit.dart';

import '../../../../export.dart';

class ActionAppBarFavorite extends StatelessWidget {
  const ActionAppBarFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FavoriteCubit>();
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
                  text: "Đã chọn ",
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
            return IconButton(
              padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
              onPressed: () => bloc.showCheckBox(),
              icon: SvgPicture.asset(
                "assets/icons/edit.svg",
                colorFilter: const ColorFilter.mode(
                  secondaryColor,
                  BlendMode.srcIn,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
