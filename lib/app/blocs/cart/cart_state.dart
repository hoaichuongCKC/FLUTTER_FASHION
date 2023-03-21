// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_cubit.dart';

class CartState extends Equatable {
  final List<CartModel> items;

  const CartState({this.items = const []});

  CartState.fromJson(Map<String, dynamic> json)
      : items = (json['items'] as List)
            .map((itemJson) => CartModel.fromJson(itemJson))
            .toList();

  Map<String, dynamic> toJson() => {
        'items': items.map((item) => item.toJson()).toList(),
      };

  int totalCart() {
    return items.fold<int>(
        0,
        (previousValue, element) =>
            previousValue +
            (element.quantity *
                (element.product.regular_price -
                    element.product.sale_price.toInt())));
  }

  CartState copyWith({
    List<CartModel>? items,
  }) {
    return CartState(
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [items];
}
