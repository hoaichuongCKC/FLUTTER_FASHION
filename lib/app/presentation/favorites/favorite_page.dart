import 'package:flutter_fashion/app/presentation/favorites/components/action_appbar_favorite.dart';
import 'package:flutter_fashion/app/presentation/favorites/components/bottom_navigationbar.dart';
import 'package:flutter_fashion/app/presentation/favorites/components/checkbox_favorite.dart';
import 'package:flutter_fashion/export.dart';
import '../../../common/components/app/background_app.dart';
import '../../../common/components/item_product.dart';
import '../notification/overylay_menu.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackgroundBlur.normal(
      onTap: () {
        MenuOverlay.instance.remove();
      },
      title: AppLocalizations.of(context)!.favorite,
      actionsSecond: const [
        ActionAppBarFavorite(),
      ],
      isHasBackground: false,
      bottomNavigationBar: const BottomNavigationBarFavorite(),
      child: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          final listProduct = state.listProduct;
          if (listProduct.isEmpty) {
            return Center(
              child: Text(
                AppLocalizations.of(context)!.no_favorite,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }
          return GridView.builder(
            itemCount: listProduct.length,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding - 4, vertical: verticalPadding),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2 / 4,
              mainAxisExtent: 230.0,
            ),
            itemBuilder: (context, index) {
              final product = listProduct[index];
              return Stack(
                key: ValueKey(product.id),
                fit: StackFit.expand,
                children: [
                  ItemProduct(
                    onTap: () {
                      final bloc = BlocProvider.of<ProductDetailCubit>(context);

                      bloc.getProduct(product.id!);

                      AppRoutes.router.pushNamed(Names.PRODUCT_DETAIL);
                    },
                    product: listProduct[index],
                  ),
                  CheckBoxFavorite(product: product),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
