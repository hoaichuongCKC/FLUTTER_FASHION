import 'package:flutter_fashion/app/blocs/banner/banner_cubit.dart';
import 'package:flutter_fashion/app/blocs/category/category_cubit.dart';
import 'package:flutter_fashion/app/blocs/product/product_cubit.dart';
import 'package:flutter_fashion/app/network_provider/banner_provider.dart';
import 'package:flutter_fashion/app/network_provider/product_provider.dart';
import 'package:flutter_fashion/app/presentation/login/export.dart';
import 'package:flutter_fashion/app/repositories/banner_repository.dart';
import 'package:flutter_fashion/app/repositories/product_repository.dart';

Future<void> initDIInjectionHome() async {
  getIt.registerLazySingleton<BannerCubit>(
    () => BannerCubit(bannerRepositoryImpl: getIt()),
  );

  getIt.registerLazySingleton<CategoryCubit>(
    () => CategoryCubit(productRepositoryImpl: getIt()),
  );

  getIt.registerLazySingleton<ProductCubit>(
    () => ProductCubit(productRepositoryImpl: getIt()),
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
}
