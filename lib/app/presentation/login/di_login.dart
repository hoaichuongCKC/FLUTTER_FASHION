// import 'package:flutter_fashion/app/blocs/auth/auth_bloc.dart';
import 'package:flutter_fashion/app/blocs/auth/auth_cubit.dart';
import 'package:flutter_fashion/app/network_provider/auth_provider.dart';
import 'package:flutter_fashion/app/repositories/auth_repository.dart';
import 'package:flutter_fashion/dependency_injection.dart';

Future<void> initDILogin() async {
  getIt.registerFactory(() => AuthCubit(auth: getIt()));

  getIt.registerLazySingleton(() => AuthRepositoryImpl(
        networkInfoImpl: getIt(),
        authProviderImpl: getIt(),
      ));

  getIt.registerLazySingleton(() => AuthProviderImpl(apiService: getIt()));
}
