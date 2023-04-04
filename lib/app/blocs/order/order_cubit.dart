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
      final updateList = [...state.awaitingList, order];
      emit(state.copyWith(awaitingList: updateList));
    } else {
      fetchOrder();
    }
  }

  void updateEvaluated(int orderId) {
    final state = this.state;

    final updatedList = [
      ...List<OrderModel>.from(state.deliveredList).map(
        (item) {
          if (item.id == orderId) {
            return item.copyWith(evaluated: true);
          }
          return item;
        },
      ).toList()
    ];

    emit(state.copyWith(deliveredList: updatedList));
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
            awaitingList: List<OrderModel>.from(state.awaitingList)
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
      (dataList) {
        final queue = Queue();
        queue.addLast(_handleDataAwait(dataList));
        queue.addLast(_handleDataProcessing(dataList));
        queue.addLast(_handleDataShipping(dataList));
        queue.addLast(_handleDataDelivered(dataList));
        queue.removeFirst();
        queue.clear();
      },
    );
  }

  _handleDataAwait(List<OrderModel> data) {
    emit(state.copyWith(status: AppStatus.success));
    if (data.isNotEmpty) {
      final state = this.state;
      emit(
        state.copyWith(
          status: AppStatus.success,
          awaitingList: List<OrderModel>.from(data)
              .where((element) => element.status == awaitingStatus)
              .toList(),
        ),
      );
    }
  }

  _handleDataProcessing(List<OrderModel> data) {
    final state = this.state;
    //check list awaiting if not null then remove data, else Don't remove data have status is awaitingStatus
    if (state.awaitingList.isNotEmpty) {
      //remove list data awating
      data.removeWhere((element) => element.status == awaitingStatus);
    }
    emit(
      state.copyWith(
        processingList: List<OrderModel>.from(data)
            .where((element) => element.status == processingStatus)
            .toList(),
      ),
    );
  }

  _handleDataShipping(List<OrderModel> data) {
    final state = this.state;
    //check list processing if not null then remove data, else Don't remove data have status is processingStatus
    if (state.processingList.isNotEmpty) {
      //remove list data awating
      data.removeWhere((element) => element.status == processingStatus);
    }

    emit(
      state.copyWith(
        shippingList: List<OrderModel>.from(data)
            .where((element) => element.status == shippingStatus)
            .toList(),
      ),
    );
  }

  _handleDataDelivered(List<OrderModel> data) {
    final state = this.state;
    //check list delivered if not null then remove data, else Don't remove data have status is deliveredStatus
    if (state.shippingList.isNotEmpty) {
      //remove list data awating
      data.removeWhere((element) => element.status == shippingStatus);
    }

    emit(
      state.copyWith(
        deliveredList: List<OrderModel>.from(data)
            .where((element) => element.status == deliveredStatus)
            .toList(),
      ),
    );
    if (state.deliveredList.isNotEmpty) {
      data.removeWhere((element) => element.status == deliveredStatus);
    }
  }
}
