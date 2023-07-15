import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/app/models/cart/cart.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/app/presentation/product_detail/export_detail.dart';
part 'product_detail_ui_state.dart';

class ProductDetailUiCubit extends Cubit<ProductDetailUiState> {
  ProductDetailUiCubit() : super(const ProductDetailUiState());

  void selectImage(String color, int indexImage) {
    emit(state.copyWith(color: color, indexImage: indexImage));
  }

  void changeSize(String size, int id) {
    emit(state.copyWith(size: size, productDetailID: id));
  }

  void changeQuantity(int qunatity) {
    emit(state.copyWith(quantity: qunatity));
  }

  void changeHasLoadmore(value) => emit(state.copyWith(hasLoadMore: value));

  void changeShowFloatingAction(bool value) {
    final state = this.state;
    if (state.isShow && value || !state.isShow && !value) {
      return;
    }
    emit(state.copyWith(isShow: !state.isShow));
  }

  void addToCart(
    BuildContext context,
    ProductModel product,
    void Function(String, int) completed,
  ) {
    final state = this.state;

    if (state.color.isEmpty) {
      showErrorToast(AppLocalizations.of(context)!.please_choose_color);

      return;
    }

    if (product.product_detail![0].size != null) {
      if (product.product_detail![0].size!.isNotEmpty) {
        if (state.size.isEmpty) {
          showErrorToast(AppLocalizations.of(context)!.please_choose_size);

          return;
        }
      }
    }
    log('${state.productDetailID}', name: 'Product Detail UI Cubit');
    final bool isCheck =
        product.product_detail![state.indexImage].size == null ||
            product.product_detail![state.indexImage].size!.isEmpty;
    final CartModel cartItem = CartModel.init(
      {
        "price": product.regular_price,
        "sale_price": product.sale_price,
        "product_detail_id": isCheck
            ? product.product_detail![state.indexImage].id
            : state.productDetailID,
        "product": product,
        "color": state.color,
        "quantity": state.quantity,
        "size": state.size,
        "photo": product.product_detail![state.indexImage].photo,
      },
    );

    BlocProvider.of<CartCubit>(context).addToCart(cartItem);

    final String photo = product.product_detail![state.indexImage].photo;

    completed(photo, cartItem.quantity);
  }
}
