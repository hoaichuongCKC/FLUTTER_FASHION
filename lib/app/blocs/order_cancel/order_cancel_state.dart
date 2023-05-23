// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'order_cancel_cubit.dart';

class OrderCancelState extends Equatable {
  final List<OrderModel> orders;
  const OrderCancelState({this.orders = const []});

  @override
  List<Object> get props => [orders];

  OrderCancelState copyWith({
    List<OrderModel>? orders,
  }) {
    return OrderCancelState(
      orders: orders ?? this.orders,
    );
  }

  List<Map<String, dynamic>> toJson() {
    return orders.map((e) => e.toJson()).toList();
  }
}
