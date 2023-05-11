import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/app/blocs/cart/cart_cubit.dart';
import 'package:flutter_fashion/app/models/cart/cart.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/app/presentation/product_detail/export_detail.dart';
import 'package:flutter_fashion/utils/alert/pop_up.dart';
part 'product_detail_ui_state.dart';

class ProductDetailUiCubit extends Cubit<ProductDetailUiState> {
  ProductDetailUiCubit() : super(const ProductDetailUiState());

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

    final ProductModel product =
        InheritedDataApp.of<ProductModel>(context)!.data;

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

    final CartModel cartItem = CartModel.init(
      {
        "product": product,
        "color": state.color,
        "quantity": state.quantity,
        "size": state.size,
        "photo": product.product_detail![state.indexImage].photo,
      },
    );

    BlocProvider.of<CartCubit>(context).addToCart(cartItem);

    completed(
        product.product_detail![state.indexImage].photo, cartItem.quantity);
  }
}
