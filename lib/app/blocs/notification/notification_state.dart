// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  final List<NotificationModel> notifications;

  final List<int> reads;

  final bool isLoading;

  final bool isFirstLoad;

  final AppStatus status;

  const NotificationState({
    this.notifications = const [],
    this.reads = const [],
    this.isLoading = false,
    this.isFirstLoad = false,
    this.status = AppStatus.init,
  });

  @override
  List<Object> get props {
    return [
      notifications,
      isLoading,
      isFirstLoad,
      reads,
      status,
    ];
  }

  NotificationState copyWith({
    List<NotificationModel>? notifications,
    List<int>? reads,
    bool? isLoading,
    bool? isFirstLoad,
    AppStatus? status,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      reads: reads ?? this.reads,
      isLoading: isLoading ?? this.isLoading,
      isFirstLoad: isFirstLoad ?? this.isFirstLoad,
      status: status ?? this.status,
    );
  }
}
