
import 'package:flutter_fashion/app/models/product/product.dart';

import '../../../../export.dart';

class CheckBoxFavorite extends StatelessWidget {
  const CheckBoxFavorite({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FavoriteCubit>();
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      buildWhen: (p, c) => p.isShowCheckBox != c.isShowCheckBox,
      builder: (context, state) {
        if (!state.isShowCheckBox) {
          return const SizedBox();
        }
        return ColoredBox(
          color: blackColor.withOpacity(0.85),
          child: BlocSelector<FavoriteCubit, FavoriteState, bool>(
            selector: (state) {
              return state.chooseItemsDelete.contains(product.id);
            },
            builder: (context, hasContaints) {
              return Checkbox(
                value: hasContaints,
                checkColor: blackColor,
                fillColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.orange.withOpacity(.32);
                    }
                    return lightColor;
                  },
                ),
                onChanged: (value) {
                  if (value!) {
                    bloc.addId(product.id!);
                    return;
                  }
                  bloc.removeId(product.id);
                },
              );
            },
          ),
        );
      },
    );
  }
}
