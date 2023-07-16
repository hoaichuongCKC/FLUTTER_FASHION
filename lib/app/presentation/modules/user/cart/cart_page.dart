import 'package:flutter_fashion/app/presentation/modules/user/cart/components/bottom_nav_cart.dart';
import 'package:flutter_fashion/app/presentation/modules/user/cart/components/item_cart.dart';
import 'package:flutter_fashion/export.dart';
import '../../../../../common/components/app/background_app.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackgroundBlur.normal(
      title: AppLocalizations.of(context)!.my_shopping_cart,
      bottomNavigationBar: const BottomNavigationBarCart(),
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(Assets.emptyCartPNG),
                    Text(
                      AppLocalizations.of(context)!.no_carts,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
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
