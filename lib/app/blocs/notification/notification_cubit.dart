import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/app/models/notification/notification_model.dart';
import 'package:flutter_fashion/app/presentation/login/export.dart';
import 'package:flutter_fashion/app/repositories/notification_repository.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepositoryImpl _notificationRepositoryImpl;

  NotificationCubit({required NotificationRepositoryImpl noti})
      : _notificationRepositoryImpl = noti,
        super(const NotificationState());

  double get scrollThresold => 150.0;

  int _currentPage = 1;

  bool _isLoading = false;

  bool _loadMore = true;

  void fetch([int? page]) async {
    _isLoading = true;
    emit(state.copyWith(status: AppStatus.loading));

    final result = await _notificationRepositoryImpl.fetch(_currentPage);

    result.fold(
      (error) => emit(state.copyWith(status: AppStatus.error)),
      (notifications) async {
        _isLoading = false;

        if (notifications.isEmpty) {
          _loadMore = false;
          emit(state.copyWith(status: AppStatus.success, isLoading: false));

          return;
        }

        _currentPage++;

        emit(
          state.copyWith(
            notifications: [...state.notifications, ...notifications],
            status: AppStatus.success,
            isLoading: false,
            isFirstLoad: true,
          ),
        );
      },
    );
  }

  void loadMore(ScrollController controller) {
    if (_isLoading || !_loadMore) return;

    final scrollLimit = controller.position.maxScrollExtent - scrollThresold;

    if (controller.offset >= scrollLimit) {
      emit(state.copyWith(isLoading: true));
      fetch(_currentPage);
    }
  }

  void add(NotificationModel notification) {
    final state = this.state;

    final updatedList = [notification, ...state.notifications];

    emit(state.copyWith(notifications: updatedList));
  }
}
