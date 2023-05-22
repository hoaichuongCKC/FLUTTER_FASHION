// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  final List<NotificationModel> notifications;
  final bool isLoading;
  final int page;
  final double scrollThresold;
  final AppStatus status;
  const NotificationState({
    this.notifications = const [],
    this.isLoading = false,
    this.page = 1,
    this.scrollThresold = 150.0,
    this.status = AppStatus.init,
  });
  @override
  List<Object> get props {
    return [
      notifications,
      isLoading,
      page,
      scrollThresold,
      status,
    ];
  }

  NotificationState copyWith({
    List<NotificationModel>? notifications,
    bool? isLoading,
    int? page,
    double? scrollThresold,
    AppStatus? status,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
      page: page ?? this.page,
      scrollThresold: scrollThresold ?? this.scrollThresold,
      status: status ?? this.status,
    );
  }
}
