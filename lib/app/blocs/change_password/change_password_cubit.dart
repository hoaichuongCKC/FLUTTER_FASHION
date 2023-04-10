import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fashion/app/repositories/user_repository.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';
import 'package:flutter_fashion/utils/alert/error.dart';
import 'package:flutter_fashion/utils/alert/loading.dart';
import 'package:flutter_fashion/utils/alert/success.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../routes/app_routes.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final UserRepositoryImpl userRepositoryImpl;
  ChangePasswordCubit({required this.userRepositoryImpl})
      : super(const ChangePasswordState());
  void onChangedCurrentPassword(String value) =>
      emit(state.copyWith(currentPass: value));

  void onChangedNewPassword(String value) =>
      emit(state.copyWith(newPass: value));

  void onChangedConfirmPassword(String value) =>
      emit(state.copyWith(confirmPass: value));

  void submitForm(BuildContext context) async {
    emit(state.copyWith(status: AppStatus.loading));

    loadingAlert(context: context);

    final result = await userRepositoryImpl.changePassword(param: state);

    //dispose loading overlay
    AppRoutes.router.pop();

    result.fold(
      (error) {
        emit(state.copyWith(status: AppStatus.error));
        errorAlert(context: context, message: error);
      },
      (data) {
        if (data.status) {
          //dispose dialog showform Password
          AppRoutes.router.pop();
          emit(state.copyWith(status: AppStatus.success));
          successAlert(context: context, message: data.message);
        } else {
          errorAlert(context: context, message: data.message);
          emit(state.copyWith(status: AppStatus.error));
        }
      },
    );
  }

  @override
  String toString() {
    super.toString();
    return "state: $state";
  }
}
