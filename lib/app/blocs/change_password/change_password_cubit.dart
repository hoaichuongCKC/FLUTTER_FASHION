// ignore_for_file: use_build_context_synchronously
import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/app/repositories/user_repository.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';
import 'package:flutter_fashion/export.dart';
import 'package:flutter_fashion/utils/alert/loading.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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
    if (!_checkPassword(context)) {
      showErrorToast(AppLocalizations.of(context)!.password_not_match);
      return;
    }

    emit(state.copyWith(status: AppStatus.loading));

    loadingAlert(context: context);

    final result = await userRepositoryImpl.changePassword(param: state);

    //dispose loading overlay
    AppRoutes.router.pop();

    result.fold(
      (error) {
        emit(state.copyWith(status: AppStatus.error));
        showErrorToast(error);
      },
      (data) {
        final status = data.data[0] as int;
        if (status == 200) {
          //dispose dialog showform Password
          AppRoutes.router.pop();
          emit(state.copyWith(status: AppStatus.success));
          showSuccessToast(
              AppLocalizations.of(context)!.changed_password_successfully);
        } else {
          showErrorToast(
              AppLocalizations.of(context)!.current_password_is_incorrect);

          emit(state.copyWith(status: AppStatus.error));
        }
      },
    );
  }

  bool _checkPassword(BuildContext context) {
    final state = this.state;

    if (state.confirmPass != state.newPass) {
      return false;
    }

    if (state.confirmPass.isEmpty || state.newPass.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  String toString() {
    super.toString();
    return "state: $state";
  }
}
