/// The `AppBarProductDetail` class is a stateless widget that displays the app bar for the product
/// detail screen, including icons for adding/removing the product from favorites and displaying the
/// number of items in the cart.
import 'package:flutter_fashion/app/blocs/cart/cart_cubit.dart';
import 'package:flutter_fashion/app/blocs/favorite/favorite_cubit.dart';
import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/utils/extensions/list.dart';

import '../../../../config/svg_files.dart';
import '../../../../export.dart';

class AppBarProductDetail extends StatelessWidget {
  const AppBarProductDetail({super.key});
  static GlobalKey appbarKey = GlobalKey();

  static Offset getOffset() {
    final box = appbarKey.currentContext!.findRenderObject() as RenderBox;

    Offset offset = box.localToGlobal(Offset.zero);

    offset = Offset(box.size.width - box.size.width * 0.4, 0);
    return offset;
  }

  @override
  Widget build(BuildContext context) {
    final ProductModel product =
        InheritedDataApp.of<ProductModel>(context)!.data;

    return LimitedBox(
      maxHeight: 60,
      child: Row(
        key: appbarKey,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Align(
              alignment: const Alignment(-1, -0.4),
              child: InkWell(
                onTap: () => AppRoutes.router.pop(),
                child: const Icon(Icons.arrow_back, size: 24),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: const Alignment(1, -0.4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: BlocSelector<FavoriteCubit, FavoriteState, bool>(
                      selector: (state) {
                        final favorites = state.listProduct;

                        if (favorites.isEmpty) {
                          return false;
                        }

                        final ischeck = List<ProductModel>.from(favorites)
                            .checkExistsId(state.idList, product.id!);

                        return ischeck != -1;
                      },
                      builder: (context, check) {
                        return _buildIconFavorite(context, product, check);
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () => AppRoutes.router.push(Routes.CART),
                    child: SizedBox(
                      width: 24.0,
                      height: 24.0,
                      child: Stack(
                        fit: StackFit.expand,
                        clipBehavior: Clip.none,
                        children: [
                          SvgPicture.asset(
                            Assets.cartSVG,
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).iconTheme.color!,
                              BlendMode.srcIn,
                            ),
                          ),
                          Positioned(
                            right: -3,
                            top: -5,
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                color: errorColor,
                                shape: BoxShape.circle,
                              ),
                              child: SizedBox(
                                width: 15.0,
                                height: 15.0,
                                child: Center(
                                  child: BlocBuilder<CartCubit, CartState>(
                                    builder: (context, state) {
                                      return Text(
                                        state.items.length.toString(),
                                        style: PrimaryFont.instance.copyWith(
                                          fontSize: 9.0,
                                          color: lightColor,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildIconFavorite(
      BuildContext context, ProductModel product, bool isFavorite) {
    return InkWell(
      onTap: () {
        if (isFavorite) {
          context.read<FavoriteCubit>().removeFavorite(product);
        } else {
          context.read<FavoriteCubit>().addFavorite(product);
        }
      },
      child: Icon(
        Icons.favorite,
        size: 24,
        color: isFavorite ? darkColor : Colors.black54,
      ),
    );
  }
}
