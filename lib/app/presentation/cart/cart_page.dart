import 'package:flutter_fashion/app/blocs/cart/cart_cubit.dart';
import 'package:flutter_fashion/app/presentation/cart/components/bottom_nav_cart.dart';
import 'package:flutter_fashion/app/presentation/cart/components/item_cart.dart';
import 'package:flutter_fashion/export.dart';
import '../../../common/components/app/background_app.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackgroundBlur.normal(
      title: AppLocalizations.of(context)!.my_shopping_cart,
      leading: InkWell(
        onTap: () => AppRoutes.router.pop(),
        child: const Icon(Icons.arrow_back),
      ),
      bottomNavigationBar: const BottomNavigationBarCart(),
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!
                      .my_shopping_cart_is_currently_empty),
                  TextButton(
                      onPressed: () {
                        AppRoutes.router.pop();
                        AppRoutes.router.pushNamed(
                          Names.CATEGORY,
                          queryParams: {
                            "search_key": "",
                            "index": 0,
                          },
                        );
                      },
                      child: const Text('Mua ngay')),
                ],
              ),
            );
          }
          return ListView.separated(
            padding:
                const EdgeInsets.symmetric(horizontal: horizontalPadding - 4),
            separatorBuilder: (context, index) => const SizedBox(height: 15.0),
            itemCount: state.items.length,
            itemBuilder: (context, index) {
              return ItemCart(
                key: ValueKey(index),
                index: index,
                item: state.items[index],
              );
            },
          );
        },
      ),
    );
  }
}
