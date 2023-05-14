import 'package:flutter_fashion/app/blocs/address_user/address_user_cubit.dart';
import 'package:flutter_fashion/app/blocs/banner/banner_cubit.dart';
import 'package:flutter_fashion/app/blocs/category/category_cubit.dart';
import 'package:flutter_fashion/app/blocs/notification/notification_cubit.dart';
import 'package:flutter_fashion/app/blocs/popular_search/popular_search_cubit.dart';
import 'package:flutter_fashion/app/blocs/product/product_cubit.dart';
import 'package:flutter_fashion/app/blocs/product_new/product_new_cubit.dart';
import 'package:flutter_fashion/app/blocs/product_sale/product_sale_cubit.dart';
import 'package:flutter_fashion/app/blocs/promotion/promotion_cubit.dart';
import 'package:flutter_fashion/app/blocs/reviews/review_cubit.dart';
import 'package:flutter_fashion/app/network_provider/banner_provider.dart';
import 'package:flutter_fashion/app/network_provider/category_provider.dart';
import 'package:flutter_fashion/app/network_provider/notification_provider.dart';
import 'package:flutter_fashion/app/network_provider/product_provider.dart';
import 'package:flutter_fashion/app/presentation/home/blocs/loadmore_bloc.dart';
import 'package:flutter_fashion/app/presentation/login/export.dart';
import 'package:flutter_fashion/app/repositories/banner_repository.dart';
import 'package:flutter_fashion/app/repositories/category_repository.dart';
import 'package:flutter_fashion/app/repositories/notification_repository.dart';
import 'package:flutter_fashion/app/repositories/product_repository.dart';

Future<void> initDIHome() async {
  // bloc product new
  getIt.registerLazySingleton<ProductNewCubit>(
    () => ProductNewCubit(getIt()),
  );

  // bloc product sale
  getIt.registerLazySingleton<ProductSaleCubit>(
    () => ProductSaleCubit(getIt()),
  );

  // bloc notification
  getIt.registerLazySingleton<NotificationCubit>(
    () => NotificationCubit(noti: getIt()),
  );
  // bloc Banner
  getIt.registerLazySingleton<BannerCubit>(
    () => BannerCubit(bannerRepositoryImpl: getIt()),
  );

  // bloc promotion
  getIt.registerLazySingleton<PromotionCubit>(
    () => PromotionCubit(productRepo: getIt()),
  );

  // bloc review
  getIt.registerLazySingleton<ReviewCubit>(
    () => ReviewCubit(getIt()),
  );

  //bloc popular product
  getIt.registerLazySingleton<PopularProductCubit>(
    () => PopularProductCubit(productRepositoryImpl: getIt()),
  );

  //bloc loadmore
  getIt.registerLazySingleton<LoadMoreProductBloc>(
    () => LoadMoreProductBloc(),
  );

  //bloc ctegory
  getIt.registerLazySingleton<CategoryCubit>(
    () => CategoryCubit(categoryRepositoryImpl: getIt()),
  );

  //bloc product
  getIt.registerLazySingleton<ProductCubit>(
    () => ProductCubit(productRepositoryImpl: getIt()),
  );

  //bloc AddressUser
  getIt.registerLazySingleton<AddressUserCubit>(
    () => AddressUserCubit(),
  );

  //Provider Category
  getIt.registerLazySingleton(
    () => CategoryProviderImpl(apiService: getIt()),
  );

  //Repository Category
  getIt.registerLazySingleton(
    () => CategoryRepositoryImpl(
      categoryProviderImpl: getIt(),
      networkInfoImpl: getIt(),
    ),
  );

  //Provider Banner
  getIt.registerLazySingleton(
    () => BannerProviderImpl(apiService: getIt()),
  );

  //Repository Banner
  getIt.registerLazySingleton(
    () => BannerRepositoryImpl(
      bannerProviderImpl: getIt(),
      networkInfoImpl: getIt(),
    ),
  );

  // Provider  Product
  getIt.registerLazySingleton(
    () => ProductProviderImpl(apiService: getIt()),
  );

  // Repository  Product
  getIt.registerLazySingleton(
    () => ProductRepositoryImpl(
      productProviderImpl: getIt(),
      networkInfoImpl: getIt(),
    ),
  );

  // Provider   Notification
  getIt.registerLazySingleton(
    () => NotificationProviderImpl(
      apiService: getIt(),
    ),
  );
  // Repository   Notification
  getIt.registerLazySingleton(
    () => NotificationRepositoryImpl(
      notificationProvider: getIt(),
      networkInfoImpl: getIt(),
    ),
  );
}
