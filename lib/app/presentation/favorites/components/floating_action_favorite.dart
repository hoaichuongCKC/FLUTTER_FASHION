import 'package:flutter_fashion/app/blocs/favorite/favorite_cubit.dart';

import '../../../../export.dart';

class FloatingActionFavorite extends StatelessWidget {
  const FloatingActionFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FavoriteCubit, FavoriteState, bool>(
      selector: (state) {
        return state.listProduct.isEmpty;
      },
      builder: (context, state) {
        if (state) {
          return const SizedBox();
        }
        return BlocBuilder<FavoriteCubit, FavoriteState>(
          buildWhen: (p, c) => p.isShowCheckBox != c.isShowCheckBox,
          builder: (context, state) {
            if (state.isShowCheckBox) {
              return const SizedBox();
            }
            return InkWell(
              onTap: () {
                final bloc = context.read<FavoriteCubit>();
                bloc.removeAll();
              },
              radius: radiusBtn,
              child: SizedBox(
                height: 45.0,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(radiusBtn),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: horizontalPadding - 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/trash.svg",
                          placeholderBuilder: (context) => ColoredBox(
                            color: disableDarkColor.withOpacity(0.5),
                          ),
                          fit: BoxFit.scaleDown,
                          width: 18.0,
                          height: 18.0,
                        ),
                        const SizedBox(width: 5.0),
                        Text(
                          AppLocalizations.of(context)!.remove_all,
                          style: PrimaryFont.instance.copyWith(
                            fontSize: 12.0,
                            color: lightColor,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
