import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/app/models/notification/notification_model.dart';
import 'package:flutter_fashion/app/presentation/login/export.dart';
import 'package:flutter_fashion/app/repositories/notification_repository.dart';
import 'package:flutter_fashion/core/parse_json_isolate/notification.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepositoryImpl _notificationRepositoryImpl;

  NotificationCubit({required NotificationRepositoryImpl noti})
      : _notificationRepositoryImpl = noti,
        super(const NotificationState());

  double get scrollThresold => state.scrollThresold;

  int get currentPage => state.page;

  set setPage(int page) => state.page + page;

  void fetch() async {
    emit(state.copyWith(status: AppStatus.loading));

    final result = await _notificationRepositoryImpl.fetch(currentPage);

    result.fold(
      (error) => emit(state.copyWith(status: AppStatus.error)),
      (notifications) async {
        final notiOrder =
            await compute(parseJson, jsonEncode(notifications["data"]));

        emit(state.copyWith(
            notifications: notiOrder, status: AppStatus.success));
      },
    );
  }

  void add(NotificationModel notification) {
    final state = this.state;

    final updatedList = [notification, ...state.notifications];

    emit(state.copyWith(notifications: updatedList));
  }

  @override
  String toString() => "state: $state";
}
