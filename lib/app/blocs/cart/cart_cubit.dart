// ignore_for_file: invalid_override_of_non_virtual_member
import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/app/blocs/user/user_cubit.dart';
import 'package:flutter_fashion/core/storage/key.dart';
import 'package:flutter_fashion/export.dart';

import '../../models/cart/cart.dart';

part 'cart_state.dart';

class CartCubit extends HydratedCubit<CartState> {
  CartCubit() : super(const CartState());

  @override
  String get storageToken =>
      KeyStorage.userCart + getIt.get<UserCubit>().user.id.toString();

  void addToCart(CartModel cart) {
    final state = this.state;

    if (_checkExists(cart)) {
      _handleUpdateQuantity(cart);
      return;
    }
    emit(state.copyWith(items: List<CartModel>.from(state.items)..add(cart)));
  }

  bool _checkExists(CartModel cart) {
    final state = this.state;
    final isExist = List<CartModel>.from(state.items).where((item) {
      final bool checkId = item.product.id == cart.product.id;

      final bool checkIndexColor = item.indexImage == cart.indexImage;

      return checkId && checkIndexColor;
    }).toList();

    return isExist.isNotEmpty;
  }

  void _handleUpdateQuantity(CartModel cart) {
    final state = this.state;

    final updatedList = List<CartModel>.from(state.items).map(
      (item) {
        if (item.product.id == cart.product.id) {
          return item.copyWith(quantity: item.quantity + cart.quantity);
        }
        return item;
      },
    ).toList();

    emit(state.copyWith(items: updatedList));
  }

  void removeFromCart(int index) {
    final state = this.state;
    emit(
      state.copyWith(items: List<CartModel>.from(state.items)..removeAt(index)),
    );
  }

  void removeAll() => emit(const CartState());

  void ins(int index) {
    final state = this.state;
    final itemToUpdate = state.items[index];

    // Create a new copy of the item with the quantity increased by 1
    final updatedItem =
        itemToUpdate.copyWith.call(quantity: itemToUpdate.quantity + 1);

    final updatedItems = List<CartModel>.from(state.items);
    updatedItems.replaceRange(index, index + 1, [updatedItem]);

    // Emit a new state with the updated items
    emit(state.copyWith(items: updatedItems));
  }

  void des(int index) {
    final state = this.state;
    final itemToUpdate = state.items[index];

    if (itemToUpdate.quantity == 1) return;
    // Create a new copy of the item with the quantity increased by 1
    final updatedItem =
        itemToUpdate.copyWith.call(quantity: itemToUpdate.quantity - 1);

    final updatedItems = List<CartModel>.from(state.items);
    updatedItems.replaceRange(index, index + 1, [updatedItem]);

    // Emit a new state with the updated items
    emit(state.copyWith(items: updatedItems));
  }

  @override
  CartState fromJson(Map<String, dynamic> json) {
    return json["items"] == null ? const CartState() : CartState.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(CartState state) {
    return state.toJson();
  }
}
