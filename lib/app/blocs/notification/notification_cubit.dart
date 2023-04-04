import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/app/models/notification/notification_model.dart';
import 'package:flutter_fashion/app/repositories/notification_repository.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepositoryImpl _notificationRepositoryImpl;

  NotificationCubit({required NotificationRepositoryImpl noti})
      : _notificationRepositoryImpl = noti,
        super(const NotificationState());

  double get _scrollThresold => state.scrollThresold;

  int get _currentPage => state.page;

  set _setPage(int page) => state.page + page;

  void fetch() async {
    emit(state.copyWith(status: AppStatus.loading));

    final result = await _notificationRepositoryImpl.fetch(_currentPage);

    result.fold(
      (error) => emit(state.copyWith(status: AppStatus.error)),
      (notifications) {
        log("$notifications");
        // emit(
        // //   // state.copyWith(
        // //   //     notifications: notifications, status: AppStatus.success),
        // // );
      },
    );
  }

  @override
  String toString() => "state: $state";
}
