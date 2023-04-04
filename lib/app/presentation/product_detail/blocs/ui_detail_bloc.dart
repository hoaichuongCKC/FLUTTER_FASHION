import 'package:flutter_fashion/app/blocs/cart/cart_cubit.dart';
import 'package:flutter_fashion/app/models/cart/cart.dart';
import 'package:flutter_fashion/export.dart';
import 'package:flutter_fashion/utils/alert/pop_up.dart';
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
    List? listSize = product.properties!.sizes;
    List? listColor = product.properties!.colors;
    bool isCheckEmptySize = false;
    bool isCheckEmptyColor = false;
    if (listSize!.isEmpty || listColor!.isEmpty) {
      //nếu danh sách listSize là rỗng thì không cần check size
      isCheckEmptySize = true;
      isCheckEmptyColor = true;
    }

    bool isCheckColor =
        isCheckEmptyColor ? false : _selectColorSubject.value.isEmpty;

    bool isCheckSize =
        isCheckEmptySize ? false : _selectSizeSubject.value.isEmpty;

    if (isCheckColor || isCheckSize) {
      _notiAlert(context);
    } else {
      CartModel cartItem = CartModel(
        color: _selectColorSubject.value,
        quantity: _counterQuantity,
        product: product,
        size: _selectSizeSubject.value,
      );
      context.read<CartCubit>().addToCart(cartItem);

      AppRoutes.router.go(Routes.CART);
    }
  }

  _notiAlert(BuildContext context) {
    popupAlert(
        hasTimer: true,
        context: context,
        message: "Vui lòng chọn màu sắc và kich thước");
  }

  void dispose() {
    _selectImageSuject.close();
    _selectColorSubject.close();
    _selectSizeSubject.close();
  }
}
