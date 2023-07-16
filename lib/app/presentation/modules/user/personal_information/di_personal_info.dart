import 'package:flutter_fashion/app/blocs/change_password/change_password_cubit.dart';
import 'package:flutter_fashion/app/blocs/edit_information/edit_information_cubit.dart';
import 'package:flutter_fashion/dependency_injection.dart';

Future<void> initDIPerosnalInfor() async {
  getIt.registerFactory(() =>
      EditInformationCubit(cameraInfo: getIt(), userRepositoryImpl: getIt()));

  getIt.registerFactory(() => ChangePasswordCubit(userRepositoryImpl: getIt()));
}
