// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  final List<NotificationModel> notifications;

  final List<int> reads;

  final bool isLoading;

  final AppStatus status;

  const NotificationState({
    this.notifications = const [],
    this.reads = const [],
    this.isLoading = false,
    this.status = AppStatus.init,
  });

  @override
  List<Object> get props {
    return [
      notifications,
      isLoading,
      reads,
      status,
    ];
  }

  NotificationState copyWith({
    List<NotificationModel>? notifications,
    List<int>? reads,
    bool? isLoading,
    AppStatus? status,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      reads: reads ?? this.reads,
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
    );
  }
}
