import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_fashion/app/presentation/home/di_injection_home.dart';
import 'package:flutter_fashion/app/presentation/login/di_login.dart';
import 'package:flutter_fashion/app/presentation/profile/di_profile.dart';
import 'package:flutter_fashion/app/presentation/setting/di_setting.dart';
import 'package:flutter_fashion/app/presentation/sign_up/di_sign_up.dart';
import 'package:flutter_fashion/core/base/repository/base_repository.dart';
import 'package:flutter_fashion/core/base/api/api.dart';
import 'package:flutter_fashion/core/camera/camera_info.dart';
import 'package:flutter_fashion/core/network/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

import 'app/presentation/personal_information/di_personal_info.dart';

GetIt getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerLazySingleton(() => Connectivity());

  getIt.registerLazySingleton(() => ImagePicker());

  getIt.registerLazySingleton(() => CameraInfo(getIt()));

  //internal app
  getIt.registerLazySingleton(() => NetworkInfoImpl(getIt()));

  getIt.registerLazySingleton(() => BaseRepository(networkInfoImpl: getIt()));

  getIt.registerLazySingleton(() => ApiService());

  initDISetting();

  initDILogin();

  initDIProfile();

  initDIPerosnalInfor();

  initDISignUp();

  initDIInjectionHome();
}
