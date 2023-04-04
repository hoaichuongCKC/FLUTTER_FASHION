import 'package:flutter_fashion/app/models/user/user_model.dart';
import 'package:flutter_fashion/app/repositories/user_repository.dart';
import 'package:flutter_fashion/app_lifecycle.dart';
import 'package:flutter_fashion/core/base/exception/exception.dart';
import 'package:flutter_fashion/core/storage/key.dart';
import 'package:flutter_fashion/export.dart';
import 'package:flutter_fashion/utils/alert/pop_up.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_state.dart';
part 'user_cubit.freezed.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepositoryImpl _userRepositoryImpl;
  bool isLoaded = false;
  UserModel? _user;

  UserCubit({required UserRepositoryImpl userRepositoryImpl})
      : _userRepositoryImpl = userRepositoryImpl,
        super(const UserState.initial());

  Future fetchUser(BuildContext? context) async {
    if (!isLoaded) {
      emit(const UserState.loading());
      final result = await _userRepositoryImpl.me();
      result.fold(
        (String error) async => _handleError(context, error),
        (userModel) {
          isLoaded = true;
          _user = userModel;

          emit(UserState.fetchCompleted(userModel));
        },
      );
    }
  }

  UserModel get user => _user != null ? _user! : UserModel.init();

  void _handleError(BuildContext? context, String error) {
    if (context != null) {
      if (error == AuthenticatedException.message) {
        popupAlert(
          context: context,
          noButtonCancle: true,
          message: "Phiên đăng nhập của bạn đã hết hạn",
          onPressed: () {
            HydratedBloc.storage.delete(KeyStorage.token);
            AppRoutes.router.pop();
            AppRoutes.router.go(Routes.LOGIN);
            dispose();
            //restart app run materialAPp
            Phoenix.rebirth(context);
          },
        );
      } else {
        emit(UserState.failure(error));
      }
    }
  }

  void updateUser(UserModel user) {
    if (isLoaded) {
      emit(UserState.fetchCompleted(user));
    }
  }

  void reset() {
    isLoaded = false;
    emit(const UserState.initial());
  }

  @override
  String toString() {
    super.toString();
    return "state: $state";
  }
}
