import 'package:flutter/material.dart';
import 'package:flutter_fashion/app/presentation/cart/components/bottom_nav_cart.dart';
import 'package:flutter_fashion/app/presentation/cart/components/item_cart.dart';
import '../../../common/components/app/background_app.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackgroundBlur.normal(
      title: 'Giỏ hàng',
      bottomNavigationBar: const BottomNavigationBarCart(),
      child: SingleChildScrollView(
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 15.0),
          itemCount: 3,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ItemCart(index: index);
          },
        ),
      ),
    );
  }
}
