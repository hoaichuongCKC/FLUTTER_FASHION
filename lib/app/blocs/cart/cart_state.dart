// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_cubit.dart';

class CartState extends Equatable {
  final List<CartModel> items;

  const CartState({this.items = const []});

  Map<String, dynamic> toJson() => {
        'items': items.map((item) => item.toJson()).toList(),
      };

  int totalCart() {
    return items.fold<int>(
      0,
      (previousValue, element) {
        final salePrice = element.product.sale_price ?? 0;
        if (salePrice == 0) {
          final regularPrice = element.product.regular_price ?? 0;
          return previousValue + (element.quantity * regularPrice);
        }
        return previousValue + (element.quantity * salePrice);
      },
    );
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
