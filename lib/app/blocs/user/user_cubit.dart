// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter_fashion/app/blocs/user/user_event.dart';
import 'package:flutter_fashion/app/models/user/user_model.dart';
import 'package:flutter_fashion/app/repositories/user_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_state.dart';
part 'user_cubit.freezed.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepositoryImpl _userRepositoryImpl;
  bool isLoaded = false;
  UserCubit({required UserRepositoryImpl userRepositoryImpl})
      : _userRepositoryImpl = userRepositoryImpl,
        super(const UserState.initial());

  void handleEvent(UserEvent event) {
    switch (event) {
      case UserEvent.fetchUser:
        _fetchUser();
        break;
      default:
    }
  }

  _fetchUser() async {
    if (!isLoaded) {
      emit(const UserState.loading());

      final result = await _userRepositoryImpl.me();

      result.fold(
        (String error) => emit(UserState.failure(error)),
        (userModel) {
          isLoaded = true;
          emit(UserState.fetchCompleted(userModel));
        },
      );
    }
  }
}
