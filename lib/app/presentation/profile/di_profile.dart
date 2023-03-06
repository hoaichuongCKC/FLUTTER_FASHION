import 'package:flutter_fashion/app/blocs/user/user_cubit.dart';
import 'package:flutter_fashion/app/network_provider/user_provider.dart';
import 'package:flutter_fashion/app/repositories/user_repository.dart';
import 'package:flutter_fashion/dependency_injection.dart';

Future<void> initDIProfile() async {
  getIt.registerLazySingleton(() => UserCubit(userRepositoryImpl: getIt()));

  getIt.registerLazySingleton(() => UserProviderImpl(apiService: getIt()));

  getIt.registerLazySingleton(() => UserRepositoryImpl(
        networkInfoImpl: getIt(),
        userProviderImpl: getIt(),
      ));
}
