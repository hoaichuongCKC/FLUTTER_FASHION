// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_cubit.dart';

class OrderState extends Equatable {
  final List<OrderModel> awaitingList;
  final List<OrderModel> processingList;
  final List<OrderModel> shippingList;
  final List<OrderModel> deliveredList;
  final List<OrderModel> completedList;
  final List<OrderModel> cancleList;
  final AppStatus status;
  const OrderState({
    this.awaitingList = const [],
    this.processingList = const [],
    this.shippingList = const [],
    this.deliveredList = const [],
    this.completedList = const [],
    this.cancleList = const [],
    this.status = AppStatus.init,
  });
  factory OrderState.initial() => const OrderState();

  @override
  List<Object> get props {
    return [
      awaitingList,
      processingList,
      shippingList,
      deliveredList,
      completedList,
      cancleList,
      status,
    ];
  }

  OrderState copyWith({
    List<OrderModel>? awaitingList,
    List<OrderModel>? processingList,
    List<OrderModel>? shippingList,
    List<OrderModel>? deliveredList,
    List<OrderModel>? completedList,
    List<OrderModel>? cancleList,
    AppStatus? status,
  }) {
    return OrderState(
      awaitingList: awaitingList ?? this.awaitingList,
      processingList: processingList ?? this.processingList,
      shippingList: shippingList ?? this.shippingList,
      deliveredList: deliveredList ?? this.deliveredList,
      completedList: completedList ?? this.completedList,
      cancleList: cancleList ?? this.cancleList,
      status: status ?? this.status,
    );
  }
}
