import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/app/blocs/cart/cart_cubit.dart';
import 'package:flutter_fashion/app/models/cart/cart.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/app/presentation/product_detail/export_detail.dart';
import 'package:flutter_fashion/utils/alert/pop_up.dart';
part 'product_detail_ui_state.dart';

class ProductDetailUiCubit extends Cubit<ProductDetailUiState> {
  ProductDetailUiCubit() : super(const ProductDetailUiState());

  void changeImage(int id) {
    final state = this.state;
    emit(state.copyWith(idImage: id));
  }

  void changeColor(String code, int index) {
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
    VoidCallback completed,
  ) {
    final state = this.state;

    final product = ProductDetailInherited.of(context).productModel;

    if (state.color.isEmpty) {
      popupAlert(
        hasTimer: true,
        context: context,
        message: AppLocalizations.of(context)!.please_choose_color,
      );
      return;
    }
    if (product.properties!.sizes!.isNotEmpty) {
      if (state.size.isEmpty) {
        popupAlert(
          hasTimer: true,
          context: context,
          message: AppLocalizations.of(context)!.please_choose_size,
        );
        return;
      }
    }

    final CartModel cartItem = CartModel(
      color: state.color,
      quantity: state.quantity,
      product: product,
      size: state.size,
      indexImage: state.indexImage,
    );

    BlocProvider.of<CartCubit>(context).addToCart(cartItem);

    completed();
  }
}
