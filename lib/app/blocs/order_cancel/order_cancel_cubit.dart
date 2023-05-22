import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_fashion/app/blocs/user/user_cubit.dart';
import 'package:flutter_fashion/app/models/order/order.dart';
import 'package:flutter_fashion/utils/alert/loading.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../core/storage/key.dart';
import '../../../dependency_injection.dart';

part 'order_cancel_state.dart';
part 'order_cancel_cubit.freezed.dart';

class OrderCancelCubit extends HydratedCubit<OrderCancelState> {
  OrderCancelCubit() : super(const OrderCancelState.initial());

  @override
  String get storageToken =>
      KeyStorage.userCancelOrder + getIt.get<UserCubit>().user.id.toString();

  List<OrderModel> get orders => state.when(
        initial: () => [],
        success: (value) => value,
      );

  void addOrder(OrderModel order) {
    emit(OrderCancelState.success(orders: [order, ...orders]));
  }

  void remove(int id) {
    final updatedList = List<OrderModel>.from(orders)
      ..removeWhere((element) => element.id == id);

    emit(OrderCancelState.success(orders: updatedList));
  }

  void buyAgain(BuildContext context, OrderModel order) {
    loadingAlert(context: context);
  }

  @override
  OrderCancelState? fromJson(Map<String, dynamic> json) {
    final convert = jsonDecode(json["state"]) as List;
    if (convert.isEmpty) return const OrderCancelState.initial();

    return OrderCancelState.success(orders: jsonDecode(json["state"]));
  }

  @override
  Map<String, dynamic>? toJson(OrderCancelState state) {
    return {
      "state": jsonEncode(orders),
    };
  }
}
