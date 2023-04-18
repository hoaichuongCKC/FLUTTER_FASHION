import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/app/blocs/cart/cart_cubit.dart';
import 'package:flutter_fashion/app/models/cart/cart.dart';
import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/app/presentation/product_detail/export_detail.dart';
import 'package:flutter_fashion/utils/alert/pop_up.dart';
part 'product_detail_ui_state.dart';

typedef QuantityOptionCallback = void Function(int);

class ProductDetailUiCubit extends Cubit<ProductDetailUiState> {
  ProductDetailUiCubit() : super(const ProductDetailUiState());
  int _indexImage = 0;

  void changeImage(int index) {
    final state = this.state;
    emit(state.copyWith(indexImage: index));
  }

  void changeColor(String code, index) {
    _indexImage = index;
    final state = this.state;
    emit(state.copyWith(color: code, indexImage: index));
  }

  void changeSize(String size) {
    final state = this.state;
    emit(state.copyWith(size: size));
  }

  void changeQuantity(int qunatity) {
    final state = this.state;
    emit(state.copyWith(quantity: qunatity));
  }

  void addToCart(
    BuildContext context,
    ProductModel product,
    QuantityOptionCallback onCompleted,
  ) {
    final state = this.state;

    final product = ProductDetailInherited.of(context).productModel;

    if (state.color.isEmpty) {
      popupAlert(
        hasTimer: true,
        context: context,
        message: "Vui lòng chọn màu sắc",
      );
      return;
    }
    if (product.properties!.sizes!.isNotEmpty) {
      if (state.size.isEmpty) {
        popupAlert(
          hasTimer: true,
          context: context,
          message: "Vui lòng chọn kích thước",
        );
        return;
      }
    }

    CartModel cartItem = CartModel(
      color: state.color,
      quantity: state.quantity,
      product: product,
      indexImage: _indexImage,
      size: state.size,
    );

    BlocProvider.of<CartCubit>(context).addToCart(cartItem);

    onCompleted(cartItem.quantity);
  }
}
