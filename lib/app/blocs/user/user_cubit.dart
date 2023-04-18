import 'package:flutter_fashion/app/models/user/user_model.dart';
import 'package:flutter_fashion/app/repositories/user_repository.dart';
import 'package:flutter_fashion/export.dart';
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

  Future fetchUser() async {
    if (!isLoaded) {
      emit(const UserState.loading());
      final result = await _userRepositoryImpl.me();
      result.fold(
        (String error) {},
        (userModel) {
          isLoaded = true;
          _user = userModel;

          emit(UserState.fetchCompleted(userModel));
        },
      );
    }
  }

  UserModel get user => _user != null ? _user! : UserModel.init();

  void updateUser(UserModel user) {
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
