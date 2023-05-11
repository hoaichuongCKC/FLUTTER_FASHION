import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/app/models/notification/notification_model.dart';
import 'package:flutter_fashion/app/presentation/login/export.dart';
import 'package:flutter_fashion/app/repositories/notification_repository.dart';
import 'package:flutter_fashion/config/notification.dart';
import 'package:flutter_fashion/core/parse_json_isolate/notification.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';
import 'package:flutter_fashion/utils/alert/error.dart';
import 'package:flutter_fashion/utils/alert/pop_up.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepositoryImpl _notificationRepositoryImpl;

  NotificationCubit({required NotificationRepositoryImpl noti})
      : _notificationRepositoryImpl = noti,
        super(const NotificationState());

  double get scrollThresold => state.scrollThresold;

  int get currentPage => state.page;

  set setPage(int page) => state.page + page;

  List<NotificationModel> get lengthChatDonotRead => state.chatDonotRead;

  List<NotificationModel> get lengthDailyDonotRead => state.dailyDonotRead;

  List<NotificationModel> get lengthOrderDonotRead => state.orderDonotRead;

  void fetch() async {
    emit(state.copyWith(status: AppStatus.loading));

    final result = await _notificationRepositoryImpl.fetch(currentPage);

    result.fold(
      (error) => emit(state.copyWith(status: AppStatus.error)),
      (notifications) {
        _handleNotiChat(notifications);
        _handleNotiDaily(notifications);
        _handleNotiOrder(notifications);
      },
    );
  }

  void _handleNotiChat(notifications) async {
    final notiChat =
        await compute(parseJson, jsonEncode(notifications["chats"]));
    emit(state.copyWith(
      notificationsChat: notiChat,
      status: AppStatus.success,
    ));
  }

  void _handleNotiOrder(notifications) async {
    final notiOrder =
        await compute(parseJson, jsonEncode(notifications["orders"]));
    emit(state.copyWith(notificationsOrder: notiOrder));
  }

  void _handleNotiDaily(notifications) async {
    final notiDaily =
        await compute(parseJson, jsonEncode(notifications["daily"]));
    emit(state.copyWith(notificationsDaily: notiDaily));
  }

  void readNotiLocal(int idNoti, String type, context) {
    _updateReadNotiApi(idNoti, type, context);
    final state = this.state;

    if (type == typeChat) {
      final updatedList =
          List<NotificationModel>.from(state.notificationsChat).map(
        (e) {
          if (e.id == idNoti) {
            return e.copyWith(is_read: 1);
          }
          return e;
        },
      ).toList();

      emit(state.copyWith(notificationsChat: updatedList));
    } else if (type == typeOrder) {
      final updatedList =
          List<NotificationModel>.from(state.notificationsOrder).map(
        (e) {
          if (e.id == idNoti) {
            return e.copyWith(is_read: 1);
          }
          return e;
        },
      ).toList();

      emit(state.copyWith(notificationsOrder: updatedList));
    } else if (type == typeDaily) {
      final updatedList =
          List<NotificationModel>.from(state.notificationsDaily).map(
        (e) {
          if (e.id == idNoti) {
            return e.copyWith(
                detail: const NotificationDetailModel(id: 0, is_read: 1));
          }
          return e;
        },
      ).toList();

      emit(state.copyWith(notificationsDaily: updatedList));
    }
  }

  void readAll(String type, context) {
    _updateReadNotiApi(-1, type, context);
    if (type == typeChat) {
      for (var element in state.chatDonotRead) {
        final updatedList =
            List<NotificationModel>.from(state.notificationsChat).map(
          (e) {
            if (e.id == element.id) {
              return e.copyWith(is_read: 1);
            }
            return e;
          },
        ).toList();

        emit(state.copyWith(notificationsChat: updatedList));
      }
    } else if (type == typeOrder) {
      for (var element in state.orderDonotRead) {
        final updatedList =
            List<NotificationModel>.from(state.notificationsOrder).map(
          (e) {
            if (e.id == element.id) {
              return e.copyWith(is_read: 1);
            }
            return e;
          },
        ).toList();

        emit(state.copyWith(notificationsOrder: updatedList));
      }
    } else if (type == typeDaily) {
      for (var element in state.dailyDonotRead) {
        final updatedList =
            List<NotificationModel>.from(state.notificationsDaily).map(
          (e) {
            if (e.id == element.id) {
              return e.copyWith(
                  detail: const NotificationDetailModel(id: 0, is_read: 1));
            }
            return e;
          },
        ).toList();

        emit(state.copyWith(notificationsDaily: updatedList));
      }
    }
  }

  void _updateReadNotiApi(
      int idNoti, String? type, BuildContext context) async {
    final result =
        await _notificationRepositoryImpl.updateReadNoti(idNoti, type);

    result.fold(
      (error) => errorAlert(context: context, message: error),
      (data) {
        popupTextAlert(
            context: context, message: "Đã đọc thông báo!!!", counter: 1);
      },
    );
  }

  @override
  String toString() => "state: $state";
}
