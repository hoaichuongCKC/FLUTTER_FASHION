import 'package:flutter_fashion/app/blocs/user/user_event.dart';
import 'package:flutter_fashion/app/models/user/user_model.dart';
import 'package:flutter_fashion/app/repositories/user_repository.dart';
import 'package:flutter_fashion/core/storage/key.dart';
import 'package:flutter_fashion/export.dart';
import 'package:flutter_fashion/utils/alert/error.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_state.dart';
part 'user_cubit.freezed.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepositoryImpl _userRepositoryImpl;
  bool isLoaded = false;
  UserCubit({required UserRepositoryImpl userRepositoryImpl})
      : _userRepositoryImpl = userRepositoryImpl,
        super(const UserState.initial());

  Future<void> call(UserEvent event,
      {BuildContext? context, UserModel? model}) async {
    switch (event) {
      case UserEvent.fetchUser:
        _fetchUser(context);
        break;
      case UserEvent.updateUser:
        if (model != null) await _updateUser(model);
        break;
      case UserEvent.init:
        isLoaded = false;
        break;
      default:
    }
  }

  _fetchUser(BuildContext? context) async {
    if (!isLoaded) {
      emit(const UserState.loading());
      final result = await _userRepositoryImpl.me();
      result.fold(
        (String error) async => _handleError(context, error),
        (userModel) {
          isLoaded = true;
          emit(UserState.fetchCompleted(userModel));
        },
      );
    }
  }

  void _handleError(BuildContext? context, String error) {
    {
      if (context != null) {
        errorAlert(context: context, message: error);
        emit(UserState.failure(error));
      }
    }
  }

  Future _updateUser(UserModel user) async {
    if (isLoaded) {
      emit(UserState.fetchCompleted(user));
    }
  }

  @override
  String toString() {
    super.toString();
    return "state: $state";
  }
}
