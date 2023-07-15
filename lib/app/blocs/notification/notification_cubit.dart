import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/app/models/notification/notification_model.dart';
import 'package:flutter_fashion/app/presentation/login/export.dart';
import 'package:flutter_fashion/app/repositories/notification_repository.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';
import 'package:flutter_fashion/core/storage/key.dart';
import 'package:flutter_fashion/utils/extensions/list.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'notification_state.dart';

class NotificationCubit extends HydratedCubit<NotificationState> {
  final NotificationRepositoryImpl _notificationRepositoryImpl;

  NotificationCubit({required NotificationRepositoryImpl noti})
      : _notificationRepositoryImpl = noti,
        super(const NotificationState());
  @override
  String get storageToken =>
      KeyStorage.userCancelOrder + getIt.get<UserCubit>().user.id.toString();
  double get scrollThresold => 150.0;

  int _currentPage = 1;

  bool _isLoading = false;

  bool _loadMore = true;

  bool _isFirstLoading = false;

  bool get isFirstLoading => _isFirstLoading;

  void fetch([int? page]) async {
    final state = this.state;
    _isLoading = true;

    if (_currentPage == 1) emit(state.copyWith(status: AppStatus.loading));

    final result = await _notificationRepositoryImpl.fetch(_currentPage);

    result.fold(
      (error) => emit(state.copyWith(status: AppStatus.error)),
      (notifications) async {
        _isLoading = false;

        if (!_isFirstLoading) _isFirstLoading = !_isFirstLoading;

        if (notifications.isEmpty) {
          _loadMore = false;
          emit(state.copyWith(status: AppStatus.success));

          return;
        }

        _currentPage++;

        emit(
          state.copyWith(
              notifications: [...state.notifications, ...notifications],
              status: AppStatus.success,
              isLoading: false),
        );
      },
    );
  }

  void loadMore(ScrollController controller) {
    if (_isLoading || !_loadMore) return;

    final scrollLimit = controller.position.maxScrollExtent - scrollThresold;

    if (controller.offset >= scrollLimit) {
      fetch(_currentPage);
    }
  }

  void add(NotificationModel notification) {
    final state = this.state;

    final updatedList = [notification, ...state.notifications];

    emit(state.copyWith(notifications: updatedList));
  }

  void read(int id,String smg) async {
    final state = this.state;

    bool isCheck = await _checkExists(id) != -1;

    if (isCheck) return;

    final updatedList = [...state.reads, id]..sort();

    emit(state.copyWith(reads: updatedList));

    showSuccessToast(smg, toastLength: Toast.LENGTH_SHORT);
  }

  void readAll(String smg) {
    for (var item in state.notifications) {
      if (state.reads.checkExistsId(state.reads, item.id) == -1) {
        final updatedList = [...state.reads, item.id]..sort();

        emit(state.copyWith(reads: updatedList));
      }
    }
    showSuccessToast(smg, toastLength: Toast.LENGTH_SHORT);
  }

  void delete(int id, String smg) async {
    Fluttertoast.cancel();
    final updatedList = List<NotificationModel>.from(state.notifications)
      ..removeWhere((element) => element.id == id);

    emit(state.copyWith(notifications: updatedList));

    showSuccessToast(smg);

    final result = await _notificationRepositoryImpl.delete(id);

    result.fold(
      (error) {
        print(
            '-----------------------------------$error --------------------------');
      },
      (response) {
        _deleteIdReads(id);
      },
    );
  }

  void deleteAll() async {
    emit(state.copyWith(notifications: []));

    final result = await _notificationRepositoryImpl.delete(-1);

    result.fold(
      (error) {
        print(
            '-----------------------------------$error --------------------------');
      },
      (response) {
        emit(state.copyWith(reads: []));
        print(
            '-----------------------------------$response --------------------------');
      },
    );
  }

  void _deleteIdReads(int id) {
    final index = state.reads.checkExistsId(state.reads, id);

    if (index == -1) return;

    final updatedList = state.reads..removeAt(index);

    emit(state.copyWith(reads: updatedList));
  }

  Future<int> _checkExists(int id) async {
    final state = this.state;

    final int check = state.reads.checkExistsId(state.reads, id);

    return check;
  }

  @override
  NotificationState? fromJson(Map<String, dynamic> json) {
    if (json["ids"] == null) {
      return const NotificationState();
    }
    return NotificationState(reads: json["ids"]);
  }

  @override
  Map<String, dynamic>? toJson(NotificationState state) {
    return {
      "ids": state.reads,
    };
  }
}
