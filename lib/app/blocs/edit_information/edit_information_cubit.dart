// ignore_for_file: depend_on_referenced_packages, unnecessary_import
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/app/presentation/personal_information/export.dart';
import 'package:flutter_fashion/app/repositories/user_repository.dart';
import 'package:flutter_fashion/core/camera/camera_info.dart';
import 'package:flutter_fashion/utils/alert/error.dart';
import 'package:flutter_fashion/utils/alert/loading.dart';
import 'package:flutter_fashion/utils/alert/pop_up.dart';
import 'package:flutter_fashion/utils/alert/success.dart';
import 'package:image_picker/image_picker.dart';
part 'edit_information_state.dart';

class EditInformationCubit extends Cubit<EditInformationState> {
  final CameraInfo cameraInfo;

  final UserRepositoryImpl userRepositoryImpl;

  bool willPop = false;

  EditInformationCubit(
      {required this.cameraInfo, required this.userRepositoryImpl})
      : super(const EditInformationState());
  void onChangedUsername(String value) => emit(
      state.copyWith(username: value.trim(), status: EditStatus.onChangeValue));

  void onChangedFullname(String value) =>
      emit(state.copyWith(fullname: value, status: EditStatus.onChangeValue));

  void onChangedPhone(String value) =>
      emit(state.copyWith(phone: value, status: EditStatus.onChangeValue));

  void onChangedEmail(String value) =>
      emit(state.copyWith(email: value, status: EditStatus.onChangeValue));

  void onChangedImage() async {
    final file = await cameraInfo.openGallery();

    final fileCompress = await cameraInfo.compressAndGetFile(
        File(file.path), "upload",
        size: const Size(150, 150));
    if (fileCompress != null) {
      emit(state.copyWith(
          image: XFile(fileCompress.path), status: EditStatus.onChangeValue));
    }
  }

  void checkWhenPopScreen(BuildContext context) {
    final state = this.state;
    if (state.status != EditStatus.init) {
      popupAlert(
        context: context,
        onPressed: () {
          willPop = true;
          AppRoutes.router.pop();
          onSubmit(context);
        },
        message:
            AppLocalizations.of(context)!.doYouWantToSaveChangedInformation,
      );
    } else {
      AppRoutes.router.pop();
    }
  }

  void onSubmit(BuildContext context) async {
    emit(state.copyWith(status: EditStatus.loading));
    loadingAlert(context: context);
    final result =
        await userRepositoryImpl.update(param: state, imageFile: state.image);
    AppRoutes.router.pop();

    result.fold(
      (error) => errorAlert(context: context, message: error),
      (data) async {
        //reset
        context.read<UserCubit>().updateUser(data);
        if (willPop) {
          AppRoutes.router.pop();
        } else {
          successAlert(
            context: context,
            message:
                AppLocalizations.of(context)!.updatedInformationSuccessfully,
          );
        }
        emit(const EditInformationState());
      },
    );
  }

  @override
  String toString() {
    super.toString();
    return "state: $state";
  }
}
