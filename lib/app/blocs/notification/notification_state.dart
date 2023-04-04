// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  final List<NotificationModel> notificationsChat;
  final List<NotificationModel> notificationsDaily;
  final List<NotificationModel> notificationsOrder;
  final bool isLoading;
  final int page;
  final double scrollThresold;
  final AppStatus status;
  const NotificationState({
    this.notificationsChat = const [],
    this.notificationsDaily = const [],
    this.notificationsOrder = const [],
    this.isLoading = false,
    this.page = 1,
    this.scrollThresold = 150.0,
    this.status = AppStatus.init,
  });
  @override
  List<Object> get props {
    return [
      notificationsChat,
      notificationsOrder,
      notificationsDaily,
      isLoading,
      page,
      scrollThresold,
      status,
    ];
  }

  NotificationState copyWith({
    List<NotificationModel>? notificationsChat,
    List<NotificationModel>? notificationsOrder,
    List<NotificationModel>? notificationsDaily,
    bool? isLoading,
    int? page,
    double? scrollThresold,
    AppStatus? status,
  }) {
    return NotificationState(
      notificationsChat: notificationsChat ?? this.notificationsChat,
      notificationsOrder: notificationsOrder ?? this.notificationsOrder,
      notificationsDaily: notificationsDaily ?? this.notificationsDaily,
      isLoading: isLoading ?? this.isLoading,
      page: page ?? this.page,
      scrollThresold: scrollThresold ?? this.scrollThresold,
      status: status ?? this.status,
    );
  }
}
