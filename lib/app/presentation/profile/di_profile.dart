import 'package:flutter_fashion/app/blocs/chat/chat_cubit.dart';
import 'package:flutter_fashion/app/blocs/create_review/create_review_cubit.dart';
import 'package:flutter_fashion/app/blocs/order/order_cubit.dart';
import 'package:flutter_fashion/app/blocs/user/user_cubit.dart';
import 'package:flutter_fashion/app/network_provider/user_provider.dart';
import 'package:flutter_fashion/app/presentation/create_address/blocs/address_management.dart';
import 'package:flutter_fashion/app/repositories/user_repository.dart';
import 'package:flutter_fashion/dependency_injection.dart';

import '../../blocs/favorite/favorite_cubit.dart';

Future<void> initDIProfile() async {
  getIt.registerLazySingleton(() => UserCubit(userRepositoryImpl: getIt()));

  getIt.registerLazySingleton(() => AddressManagementBloc());

  getIt.registerLazySingleton(() => UserProviderImpl(apiService: getIt()));

  getIt.registerLazySingleton(() => OrderCubit(orderRepositoryImpl: getIt()));

  getIt.registerLazySingleton(() => FavoriteCubit());

  getIt.registerLazySingleton(() => ChatCubit(userRepo: getIt()));

  getIt.registerFactory(() =>
      CreateReviewCubit(productRepositoryImpl: getIt(), cameraInfo: getIt()));

  getIt.registerLazySingleton(
    () => UserRepositoryImpl(
      networkInfoImpl: getIt(),
      userProviderImpl: getIt(),
    ),
  );
}
