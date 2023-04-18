import 'package:flutter_fashion/app/blocs/address_user/address_user_cubit.dart';
import 'package:flutter_fashion/app/blocs/banner/banner_cubit.dart';
import 'package:flutter_fashion/app/blocs/category/category_cubit.dart';
import 'package:flutter_fashion/app/blocs/notification/notification_cubit.dart';
import 'package:flutter_fashion/app/blocs/popular_search/popular_search_cubit.dart';
import 'package:flutter_fashion/app/blocs/product/product_cubit.dart';
import 'package:flutter_fashion/app/blocs/promotion/promotion_cubit.dart';
import 'package:flutter_fashion/app/blocs/review/review_cubit.dart';
import 'package:flutter_fashion/app/network_provider/banner_provider.dart';
import 'package:flutter_fashion/app/network_provider/notification_provider.dart';
import 'package:flutter_fashion/app/network_provider/product_provider.dart';
import 'package:flutter_fashion/app/presentation/home/blocs/loadmore_bloc.dart';
import 'package:flutter_fashion/app/presentation/login/export.dart';
import 'package:flutter_fashion/app/repositories/banner_repository.dart';
import 'package:flutter_fashion/app/repositories/notification_repository.dart';
import 'package:flutter_fashion/app/repositories/product_repository.dart';

Future<void> initDIHome() async {
  getIt.registerLazySingleton<NotificationCubit>(
    () => NotificationCubit(noti: getIt()),
  );

  getIt.registerLazySingleton<BannerCubit>(
    () => BannerCubit(bannerRepositoryImpl: getIt()),
  );

  getIt.registerLazySingleton<PromotionCubit>(
    () => PromotionCubit(productRepo: getIt()),
  );

  getIt.registerLazySingleton<ReviewCubit>(
    () => ReviewCubit(getIt()),
  );

  getIt.registerLazySingleton<PopularSearchCubit>(
    () => PopularSearchCubit(productRepositoryImpl: getIt()),
  );

  getIt.registerLazySingleton<LoadMoreProductBloc>(
    () => LoadMoreProductBloc(),
  );

  getIt.registerLazySingleton<CategoryCubit>(
    () => CategoryCubit(productRepositoryImpl: getIt()),
  );

  getIt.registerLazySingleton<ProductCubit>(
    () => ProductCubit(productRepositoryImpl: getIt()),
  );

  getIt.registerLazySingleton<AddressUserCubit>(
    () => AddressUserCubit(),
  );

  getIt.registerLazySingleton(
    () => BannerProviderImpl(apiService: getIt()),
  );

  getIt.registerLazySingleton(
    () => BannerRepositoryImpl(
      bannerProviderImpl: getIt(),
      networkInfoImpl: getIt(),
    ),
  );

  getIt.registerLazySingleton(
    () => ProductProviderImpl(apiService: getIt()),
  );

  getIt.registerLazySingleton(
    () => ProductRepositoryImpl(
      productProviderImpl: getIt(),
      networkInfoImpl: getIt(),
    ),
  );

  getIt.registerLazySingleton(
    () => NotificationProviderImpl(
      apiService: getIt(),
    ),
  );

  getIt.registerLazySingleton(
    () => NotificationRepositoryImpl(
      notificationProvider: getIt(),
      networkInfoImpl: getIt(),
    ),
  );
}
