// ignore_for_file: invalid_override_of_non_virtual_member
import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/app/blocs/user/user_cubit.dart';
import 'package:flutter_fashion/core/storage/key.dart';
import 'package:flutter_fashion/export.dart';
import 'package:flutter_fashion/utils/extensions/datetime.dart';
import '../../../utils/alert/dialog.dart';
import '../../models/cart/cart.dart';

part 'cart_state.dart';

class CartCubit extends HydratedCubit<CartState> {
  CartCubit() : super(const CartState());

  @override
  String get storageToken =>
      KeyStorage.userCart + getIt.get<UserCubit>().user.id.toString();
  void addToListCart(List<CartModel> carts) {
    final state = this.state;

    final updatedList = [...carts, ...state.items];

    emit(state.copyWith(items: updatedList));
  }

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

      final bool checkIndexColor = item.photo == cart.photo;

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

  void removeFromCart(int index, BuildContext context) async {
    final state = this.state;

    final applocalizations = AppLocalizations.of(context)!;

    //show dialog
    final bool? isAcceptRemove = await showCustomDialog<bool>(
      context,
      title: applocalizations.my_shopping_cart,
      content: applocalizations.are_you_sure_to_delete,
      submitNameFirst: applocalizations.cancel,
      submitNameSecond: applocalizations.ok,
      onFirst: () => AppRoutes.router.pop<bool>(false),
      onSecond: () => AppRoutes.router.pop<bool>(true),
    );

    if (isAcceptRemove == null) return;

    if (!isAcceptRemove) return;

    final updatedList = List<CartModel>.from(state.items)..removeAt(index);

    emit(state.copyWith(items: updatedList));
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
    final list = _checkExpired(json);

    return list.isEmpty ? const CartState() : CartState(items: list);
  }

  @override
  Map<String, dynamic> toJson(CartState state) {
    return state.toJson();
  }

  List<CartModel> _checkExpired(json) {
    if (json['items'].isEmpty) {
      return [];
    }
    List<CartModel> carts = (json['items'] as List).map(
      (itemJson) {
        final cart = CartModel.fromJson(itemJson);

        return cart;
      },
    ).toList();

    carts = carts
      ..retainWhere(
        (item) => item.created_at.expiredCart,
      );

    return carts;
  }
}
