// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_cubit.dart';

class OrderState extends Equatable {
  final List<OrderModel> toPayList;
  final List<OrderModel> toShipList;
  final List<OrderModel> toReceiveList;
  final List<OrderModel> completedList;
  final List<OrderModel> cancleList;
  final AppStatus status;
  const OrderState({
    this.toPayList = const [],
    this.toShipList = const [],
    this.toReceiveList = const [],
    this.completedList = const [],
    this.cancleList = const [],
    this.status = AppStatus.init,
  });
  factory OrderState.initial() => const OrderState();

  @override
  List<Object> get props {
    return [
      toPayList,
      toShipList,
      toReceiveList,
      completedList,
      cancleList,
      status
    ];
  }

  OrderState copyWith({
    List<OrderModel>? toPayList,
    List<OrderModel>? toShipList,
    List<OrderModel>? toReceiveList,
    List<OrderModel>? completedList,
    List<OrderModel>? cancleList,
    AppStatus? status,
  }) {
    return OrderState(
      toPayList: toPayList ?? this.toPayList,
      toShipList: toShipList ?? this.toShipList,
      toReceiveList: toReceiveList ?? this.toReceiveList,
      completedList: completedList ?? this.completedList,
      cancleList: cancleList ?? this.cancleList,
      status: status ?? this.status,
    );
  }
}
