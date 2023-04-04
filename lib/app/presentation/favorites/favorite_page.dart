import 'package:flutter_fashion/app/blocs/favorite/favorite_cubit.dart';
import 'package:flutter_fashion/export.dart';
import '../../../common/components/app/background_app.dart';
import '../../../common/components/item_product.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackgroundBlur.normal(
      title: AppLocalizations.of(context)!.favorite,
      isHasBackground: false,
      floatingActionButton: BlocSelector<FavoriteCubit, FavoriteState, bool>(
        selector: (state) {
          return state.listProduct.isEmpty;
        },
        builder: (context, state) {
          if (state) {
            return const SizedBox();
          }
          return ButtonWidget(
            btnColor: primaryColor,
            width: 120.0,
            height: 40.0,
            animate: true,
            onPressed: () => context.read<FavoriteCubit>().removeAll(),
            radius: radiusBtn,
            labelWidget: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  child: SvgPicture.asset(
                    "assets/icons/trash.svg",
                    placeholderBuilder: (context) => ColoredBox(
                      color: disableDarkColor.withOpacity(0.5),
                    ),
                    fit: BoxFit.contain,
                    width: 20.0,
                    height: 20.0,
                  ),
                ),
                const SizedBox(width: 5.0),
                Align(
                  child: Text(
                    "Xoá tất cả",
                    style: PrimaryFont.instance.copyWith(
                      fontSize: 14.0,
                      color: lightColor,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
      child: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          final listProduct = state.listProduct;
          if (listProduct.isEmpty) {
            return Center(
              child: Text(AppLocalizations.of(context)!
                  .you_currently_have_no_product_favorite),
            );
          }
          return GridView.builder(
            itemCount: listProduct.length,
            shrinkWrap: true,
            padding:
                const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2 / 4,
              mainAxisExtent: 230.0,
            ),
            itemBuilder: (context, index) {
              return ItemProduct(
                onTap: () {},
                product: listProduct[index],
              );
            },
          );
        },
      ),
    );
  }
}
