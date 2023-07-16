import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/app/presentation/modules/user/personal_information/export.dart';
import 'package:flutter_fashion/app/repositories/user_repository.dart';
import 'package:flutter_fashion/core/camera/camera_info.dart';
import 'package:flutter_fashion/utils/alert/dialog.dart';
import 'package:flutter_fashion/utils/alert/loading.dart';
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

  void onChangedImage({XFile? file}) async {
    if (file == null) {
      final XFile? file = await getIt.get<CameraInfo>().chooseImage();

      if (file == null) return;

      emit(state.copyWith(image: file, status: EditStatus.onChangeValue));
    }
    emit(state.copyWith(image: file, status: EditStatus.onChangeValue));
  }

  void checkWhenPopScreen(BuildContext context) {
    final state = this.state;
    if (state.status != EditStatus.init) {
      showCustomDialog(
        context,
        content:
            AppLocalizations.of(context)!.doYouWantToSaveChangedInformation,
        title: AppLocalizations.of(context)!.editInformation,
        submitNameFirst: AppLocalizations.of(context)!.cancel,
        submitNameSecond: AppLocalizations.of(context)!.ok,
        onFirst: () {},
        onSecond: () {
          willPop = true;
          AppRoutes.router.pop();
          onSubmit(context);
        },
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
      (error) => showErrorToast(error),
      (data) async {
        //reset
        context.read<UserCubit>().updateUser(data);
        if (willPop) {
          AppRoutes.router.pop();
        } else {
          final text =
              AppLocalizations.of(context)!.updated_information_successfully;
          showSuccessToast(text);
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
