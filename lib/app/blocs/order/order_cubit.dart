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

  void updateStatus(dynamic idOrder, dynamic status) {
    print(idOrder);
    print(status);
    switch (status) {
      case toShipStatus:
        _updateToShip(idOrder, status);
        break;
      case toReceive:
        _updateToReceive(idOrder, status);
        break;

      case deliveredStatus:
        _updateToCompleted(idOrder, status);
        break;
    }

    // final updatedList = List<OrderModel>.from(state.)
  }

  /// This function updates the status of an order and moves it from the toPayList to the toShipList in
  /// the state.
  ///
  /// Args:
  ///   id (int): The id parameter is an integer that represents the unique identifier of an order.
  ///   status (int): The "status" parameter is an integer value representing the updated status of an
  /// order. It is used to update the "status_id" field of an order in the "toPayList" list.
  void _updateToShip(int id, int status) {
    print('_updateToShip');
    OrderModel getOrder = List<OrderModel>.from(state.toPayList)
        .firstWhere((element) => element.id == id);

    getOrder = getOrder.copyWith(status_id: status);

    final updatedToShip = [
      getOrder.copyWith(status_id: status),
      ...state.toShipList
    ];

    //remove order to pay
    final updatedToPays = List<OrderModel>.from(state.toPayList)
      ..removeWhere((element) => element.id == id);

    emit(state.copyWith(toShipList: updatedToShip, toPayList: updatedToPays));
  }

  /// This function updates the status of an order and moves it from a "to ship" list to a "to receive"
  /// list.
  ///
  /// Args:
  ///   id (int): The id parameter is an integer that represents the unique identifier of an order.
  ///   status (int): The "status" parameter is an integer representing the updated status of an order.
  /// It is used to update the "status_id" field of an order in the "getOrder" variable.
  void _updateToReceive(int id, int status) {
    print('updateToReceive');
    OrderModel getOrder = List<OrderModel>.from(state.toShipList)
        .firstWhere((element) => element.id == id);

    getOrder = getOrder.copyWith(status_id: status);

    final updatedToReceive = [getOrder, ...state.toReceiveList];

    //remove order to pay
    final updatedToShip = List<OrderModel>.from(state.toShipList)
      ..removeWhere((element) => element.id == id);

    emit(state.copyWith(
        toReceiveList: updatedToReceive, toShipList: updatedToShip));
  }

  /// This function updates the status of an order to completed and moves it from the toReceiveList to
  /// the completedList in the state.
  ///
  /// Args:
  ///   id (int): The id parameter is an integer that represents the unique identifier of an order.
  ///   status (int): The "status" parameter is an integer representing the new status ID that the order
  /// should be updated to.
  void _updateToCompleted(int id, int status) {
    print('_updateToCompleted');
    OrderModel getOrder = List<OrderModel>.from(state.toReceiveList)
        .firstWhere((element) => element.id == id);

    getOrder = getOrder.copyWith(status_id: status, evaluated: true);

    final updatedTocompleted = [getOrder, ...state.completedList];

    //remove order to pay
    final updatedToReceive = List<OrderModel>.from(state.toReceiveList)
      ..removeWhere((element) => element.id == id);

    emit(state.copyWith(
        completedList: updatedTocompleted, toReceiveList: updatedToReceive));
  }

  /// This function adds an order to a list and fetches the order if a certain condition is not met.
  ///
  /// Args:
  ///   order (OrderModel): The parameter "order" is an instance of the "OrderModel" class, which
  /// represents an order that a user wants to add to a list of orders to be paid.
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

        showSuccessToast(
            AppLocalizations.of(context)!.order_deleted_successfully);
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
