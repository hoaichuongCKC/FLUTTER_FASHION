import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_fashion/app/blocs/notification/notification_cubit.dart';
import 'package:flutter_fashion/app/blocs/order/order_cubit.dart';
import 'package:flutter_fashion/app/blocs/order_cancel/order_cancel_cubit.dart';
import 'package:flutter_fashion/app/blocs/search/search_cubit.dart';
import 'package:flutter_fashion/app/blocs/user/user_cubit.dart';
import 'package:flutter_fashion/app/presentation/modules/user/category/di_category.dart';
import 'package:flutter_fashion/app/presentation/modules/user/home/di_injection_home.dart';
import 'package:flutter_fashion/app/presentation/login/di_login.dart';
import 'package:flutter_fashion/app/presentation/modules/user/payment/dependency_injection.dart';
import 'package:flutter_fashion/app/presentation/modules/user/product_detail/depedency_injection.dart';
import 'package:flutter_fashion/app/presentation/modules/user/profile/di_profile.dart';
import 'package:flutter_fashion/app/presentation/modules/user/setting/di_setting.dart';
import 'package:flutter_fashion/app/presentation/sign_up/di_sign_up.dart';
import 'package:flutter_fashion/core/base/repository/base_repository.dart';
import 'package:flutter_fashion/core/base/api/api.dart';
import 'package:flutter_fashion/core/camera/camera_info.dart';
import 'package:flutter_fashion/core/network/network_info.dart';
import 'package:flutter_fashion/core/pusher/channels.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'app/blocs/address_user/address_user_cubit.dart';
import 'app/blocs/cart/cart_cubit.dart';
import 'app/blocs/favorite/favorite_cubit.dart';
import 'app/presentation/modules/user/personal_information/di_personal_info.dart';

GetIt getIt = GetIt.instance;

Future<void> init() async {
  //bloc storage
  getIt.registerLazySingleton(() => SearchCubit(getIt()));

  getIt.registerLazySingleton(() => OrderCancelCubit(getIt()));

  getIt.registerLazySingleton(() => Connectivity());

  getIt.registerLazySingleton(() => ImagePicker());

  getIt.registerLazySingleton(() => CameraInfo(getIt()));

  //internal app
  getIt.registerLazySingleton(() => NetworkInfoImpl(getIt()));

  getIt.registerLazySingleton(() => ChannelUserApp(apiService: getIt()));

  getIt.registerLazySingleton(() => BaseRepository(networkInfoImpl: getIt()));

  getIt.registerLazySingleton(() => ApiService());

  initDISetting();

  initDILogin();

  initDIProfile();

  initDIPerosnalInfor();

  initDISignUp();

  initDIHome();

  initDICategory();

  initProductDetail();

  initDIOrder();
}

void dispose() {
  destroyRegister<UserCubit>();
  destroyRegister<CartCubit>();
  destroyRegister<AddressUserCubit>();
  destroyRegister<FavoriteCubit>();
  destroyRegister<OrderCubit>();
  destroyRegister<NotificationCubit>();
  destroyRegister<SearchCubit>();
  //register DI again
  getIt.registerLazySingleton(() => UserCubit(userRepositoryImpl: getIt()));
  getIt.registerLazySingleton(() => FavoriteCubit());
  getIt.registerLazySingleton(() => CartCubit());
  getIt.registerLazySingleton(() => OrderCubit(orderRepositoryImpl: getIt()));
  getIt.registerLazySingleton(() => AddressUserCubit());
  getIt.registerLazySingleton(() => NotificationCubit(noti: getIt()));
  getIt.registerLazySingleton(() => SearchCubit(getIt()));
}

void destroyRegister<T extends Object>() {
  if (getIt.isRegistered<T>()) {
    getIt.unregister<T>();
  }
}
