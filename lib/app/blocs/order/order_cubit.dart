import 'dart:collection';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/app/models/order/order.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/app/repositories/order_repository.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';

import '../../../utils/alert/loading.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepositoryImpl _orderRepositoryImpl;

  OrderCubit({required OrderRepositoryImpl orderRepositoryImpl})
      : _orderRepositoryImpl = orderRepositoryImpl,
        super(OrderState.initial());

  void addOrder(OrderModel order) {
    if (getIt.isRegistered<OrderCubit>()) {
      final state = this.state;
      final updateList = [...state.toPayList, order];
      emit(state.copyWith(toPayList: updateList));
    } else {
      fetchOrder();
    }
  }

  void updateEvaluated(int orderId) {
    final state = this.state;

    final updatedList = [
      ...List<OrderModel>.from(state.completedList).map(
        (item) {
          if (item.id == orderId) {
            return item.copyWith(evaluated: true);
          }
          return item;
        },
      ).toList()
    ];

    emit(state.copyWith(completedList: updatedList));
  }

  void delete(int orderId, BuildContext context) async {
    loadingAlert(context: context);
    final result = await _orderRepositoryImpl.delete(orderId);
    AppRoutes.router.pop();
    result.fold(
      (l) {
        log("error delete order: $l");
      },
      (statusCode) {
        final state = this.state;

        //pop dialog and page
        AppRoutes.router.pop();
        AppRoutes.router.pop();
        emit(state.copyWith(
            toPayList: List<OrderModel>.from(state.toPayList)
              ..removeWhere((e) => e.id == orderId)));
        AppSnackbarMessenger.showMessage(content: "Xoá đơn hàng thành công");
      },
    );
  }

  void fetchOrder() async {
    emit(state.copyWith(status: AppStatus.loading));

    final result = await _orderRepositoryImpl.fetchOrder();

    result.fold(
      (error) => emit(state.copyWith(status: AppStatus.error)),
      (dataMap) {
        final queue = Queue<void>();

        queue.addLast(_handleToPay(dataMap));
        queue.addLast(_handleToShip(dataMap));
        queue.addLast(_handleToReceive(dataMap));
        queue.addLast(_handleDataDelivered(dataMap));
        queue.removeFirst();
        queue.clear();
      },
    );
  }

  void _handleToPay(Map<String, dynamic> data) {
    log("=========================To_pay=========================");
    emit(state.copyWith(status: AppStatus.success));

    final listMap = data["to_pay"];

    if (listMap.isNotEmpty) {
      final state = this.state;

      final list = OrderModel.orderListFromJson(listMap);

      emit(state.copyWith(toPayList: list));
    }
  }

  void _handleToShip(Map<String, dynamic> data) {
    log("=========================to_ship=========================");
    final listMap = data["to_ship"];

    if (listMap.isNotEmpty) {
      final state = this.state;

      final list = OrderModel.orderListFromJson(listMap);

      emit(state.copyWith(toShipList: list));
    }
  }

  void _handleToReceive(Map<String, dynamic> data) {
    log("=========================to_receive=========================");
    final listMap = data["to_receive"];

    if (listMap.isNotEmpty) {
      final state = this.state;

      final list = OrderModel.orderListFromJson(listMap);

      emit(state.copyWith(toReceiveList: list));
    }
  }

  void _handleDataDelivered(Map<String, dynamic> data) {
    log("=========================completed=========================");
    final listMap = data["completed"];

    if (listMap.isNotEmpty) {
      final state = this.state;

      final list = OrderModel.orderListFromJson(listMap);

      emit(state.copyWith(completedList: list));
    }
  }
}
