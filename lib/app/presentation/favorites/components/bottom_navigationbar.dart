import 'package:flutter_fashion/app/blocs/favorite/favorite_cubit.dart';

import '../../../../export.dart';

class BottomNavigationBarFavorite extends StatelessWidget {
  const BottomNavigationBarFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FavoriteCubit>();
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      buildWhen: (p, c) => p.isShowCheckBox != c.isShowCheckBox,
      builder: (context, state) {
        if (!state.isShowCheckBox) {
          return const SizedBox();
        }
        return Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ButtonWidget(
                background: secondaryColor,
                onPressed: () => bloc.removeListFavorite(),
                child: Text(
                  AppLocalizations.of(context)!.remove_all.substring(0, 3),
                  style: PrimaryFont.instance.copyWith(
                    color: lightColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              ButtonWidget(
                background: secondaryColor,
                onPressed: () => bloc.showCheckBox(),
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                  style: PrimaryFont.instance.copyWith(
                    color: lightColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
