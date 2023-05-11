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
                animate: true,
                btnColor: primaryColor,
                radius: radiusBtn,
                onPressed: () => bloc.removeListFavorite(),
                label: AppLocalizations.of(context)!.remove_all.substring(0, 3),
              ),
              const SizedBox(height: 8.0),
              ButtonWidget(
                animate: true,
                btnColor: primaryColor,
                radius: radiusBtn,
                onPressed: () => bloc.showCheckBox(),
                label: AppLocalizations.of(context)!.cancel,
              ),
            ],
          ),
        );
      },
    );
  }
}
