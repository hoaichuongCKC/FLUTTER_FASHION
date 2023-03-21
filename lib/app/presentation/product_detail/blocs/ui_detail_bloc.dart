import 'package:flutter_fashion/app/blocs/cart/cart_cubit.dart';
import 'package:flutter_fashion/app/models/cart/cart.dart';
import 'package:flutter_fashion/export.dart';
import 'package:rxdart/rxdart.dart';

import '../../../models/product/product.dart';

class UiDetailShowBloc {
  UiDetailShowBloc();

  late BehaviorSubject<int> _selectImageSuject;

  late BehaviorSubject<String> _selectColorSubject;

  late BehaviorSubject<String> _selectSizeSubject;

  late int _counterQuantity;

  BehaviorSubject<int> get imageStream => _selectImageSuject;

  BehaviorSubject<String> get colorStream => _selectColorSubject;

  BehaviorSubject<String> get sizeStream => _selectSizeSubject;

  void selectColor(String color) => _selectColorSubject.add(color);

  void selectSize(String size) => _selectSizeSubject.add(size);

  void counter(int quantity) => _counterQuantity = quantity;

  void init() {
    _selectImageSuject = BehaviorSubject.seeded(0);
    _counterQuantity = 1;

    _selectColorSubject = BehaviorSubject.seeded("");
    _selectSizeSubject = BehaviorSubject.seeded("");
  }

  void selectImage(int index) => _selectImageSuject.add(index);

  void addToCart(BuildContext context, ProductModel product) {
    CartModel cartItem = CartModel(
      color: _selectColorSubject.value,
      quantity: _counterQuantity,
      product: product,
      size: _selectSizeSubject.value,
    );
    context.read<CartCubit>().addToCart(cartItem);

    AppRoutes.router.go(Routes.CART);
  }

  void dispose() {
    _selectImageSuject.close();
    _selectColorSubject.close();
    _selectSizeSubject.close();
  }
}
