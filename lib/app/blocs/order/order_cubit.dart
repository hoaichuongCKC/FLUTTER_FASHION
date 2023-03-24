import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/app/models/order/order.dart';
import 'package:flutter_fashion/app/repositories/order_repository.dart';
import 'package:flutter_fashion/config/constant.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepositoryImpl _orderRepositoryImpl;

  OrderCubit({required OrderRepositoryImpl orderRepositoryImpl})
      : _orderRepositoryImpl = orderRepositoryImpl,
        super(OrderState.initial());

  void fetchOrder() async {
    emit(state.copyWith(status: AppStatus.loading));

    final result = await _orderRepositoryImpl.fetchOrder();

    result.fold(
      (error) => emit(state.copyWith(status: AppStatus.error)),
      (dataList) => _handleData(dataList),
    );
  }

  _handleData(List<OrderModel> data) {
    emit(state.copyWith(status: AppStatus.success));
    if (data.isNotEmpty) {
      final state = this.state;
      log("data init: $data");

      emit(
        state.copyWith(
          status: AppStatus.success,
          awaitingList: List<OrderModel>.from(
            data..where((element) => element.status == awaitingStatus).toList(),
          ),
        ),
      );
      log("data handled:  ${data.length}");
      //remove list data awating
      data.removeWhere((element) => element.status == awaitingStatus);
    }
  }
}
