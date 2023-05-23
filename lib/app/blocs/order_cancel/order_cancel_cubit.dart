import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/app/blocs/user/user_cubit.dart';
import 'package:flutter_fashion/app/models/order/order.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../core/storage/key.dart';
import '../../../dependency_injection.dart';

part 'order_cancel_state.dart';

class OrderCancelCubit extends HydratedCubit<OrderCancelState> {
  OrderCancelCubit() : super(const OrderCancelState());

  @override
  String get storageToken =>
      KeyStorage.userCancelOrder + getIt.get<UserCubit>().user.id.toString();

  void addOrder(OrderModel order) {
    emit(state.copyWith(orders: [order, ...state.orders]));
  }

  void remove(int id) {
    final updatedList = List<OrderModel>.from(state.orders)
      ..removeWhere((element) => element.id == id);

    emit(state.copyWith(orders: updatedList));
  }

  @override
  OrderCancelState? fromJson(Map<String, dynamic> json) {
    final convert = (json["state"]);

    if (convert.isEmpty) return const OrderCancelState();

    final list = OrderModel.orderListFromJson(convert);

    return OrderCancelState(orders: list);
  }

  @override
  Map<String, dynamic>? toJson(OrderCancelState state) {
    return {
      "state": state.toJson(),
    };
  }
}
