import 'package:flutter_fashion/app/models/cart/cart.dart';

extension ListX on List<CartModel> {
  double getCostOrder() {
    return fold<double>(
      0,
      (previousValue, element) =>
          previousValue +
          (element.quantity *
              (element.product.regular_price! -
                  element.product.sale_price!.toInt())),
    );
  }
}
