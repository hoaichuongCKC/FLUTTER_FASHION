import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_fashion/app/presentation/login/di_login.dart';
import 'package:flutter_fashion/app/presentation/profile/di_profile.dart';
import 'package:flutter_fashion/app/presentation/setting/di_setting.dart';
import 'package:flutter_fashion/core/base/repository/base_repository.dart';
import 'package:flutter_fashion/core/base/api/api.dart';
import 'package:flutter_fashion/core/network/network_info.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerLazySingleton(() => Connectivity());

  //internal app
  getIt.registerLazySingleton(() => NetworkInfoImpl(getIt()));

  getIt.registerSingleton(() => BaseRepository(networkInfoImpl: getIt()));

  getIt.registerLazySingleton(() => ApiService());
  initDISetting();
  initDILogin();
  initDIProfile();
}
