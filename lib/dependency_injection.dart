import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_fashion/app/blocs/chat/chat_cubit.dart';
import 'package:flutter_fashion/app/blocs/order/order_cubit.dart';
import 'package:flutter_fashion/app/blocs/user/user_cubit.dart';
import 'package:flutter_fashion/app/presentation/home/di_injection_home.dart';
import 'package:flutter_fashion/app/presentation/login/di_login.dart';
import 'package:flutter_fashion/app/presentation/payment/dependency_injection.dart';
import 'package:flutter_fashion/app/presentation/product_detail/depedency_injection.dart';
import 'package:flutter_fashion/app/presentation/profile/di_profile.dart';
import 'package:flutter_fashion/app/presentation/search/dependency_injection.dart';
import 'package:flutter_fashion/app/presentation/setting/di_setting.dart';
import 'package:flutter_fashion/app/presentation/sign_up/di_sign_up.dart';
import 'package:flutter_fashion/core/base/repository/base_repository.dart';
import 'package:flutter_fashion/core/base/api/api.dart';
import 'package:flutter_fashion/core/camera/camera_info.dart';
import 'package:flutter_fashion/core/network/network_info.dart';
import 'package:flutter_fashion/core/pusher/chat.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'app/blocs/address_user/address_user_cubit.dart';
import 'app/blocs/cart/cart_cubit.dart';
import 'app/blocs/favorite/favorite_cubit.dart';
import 'app/blocs/payment/payment.dart';
import 'app/presentation/category/di_category.dart';
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

  initDIHome();

  initDISearch();

  initDICategory();

  initProductDetail();

  initDIOrder();
}

void dispose() {
  getIt.unregister<UserCubit>();
  if (getIt.isRegistered<CartCubit>()) {
    getIt.unregister<CartCubit>();
  }
  if (getIt.isRegistered<AddressUserCubit>()) {
    getIt.unregister<AddressUserCubit>();
  }
  if (getIt.isRegistered<PaymentCubit>()) {
    getIt.unregister<PaymentCubit>();
  }
  if (getIt.isRegistered<FavoriteCubit>()) {
    getIt.unregister<FavoriteCubit>();
  }
  if (getIt.isRegistered<OrderCubit>()) {
    getIt.unregister<OrderCubit>();
  }
  if (getIt.isRegistered<PusherChatApp>()) {
    getIt.unregister<PusherChatApp>();
  }
  if (getIt.isRegistered<ChatCubit>()) {
    getIt.unregister<ChatCubit>();
  }
  //register DI again
  getIt.registerLazySingleton(() => UserCubit(userRepositoryImpl: getIt()));
  getIt.registerLazySingleton(() => FavoriteCubit());
  getIt.registerLazySingleton(() => CartCubit());
  getIt.registerLazySingleton(() => OrderCubit(orderRepositoryImpl: getIt()));
  getIt.registerLazySingleton(() => AddressUserCubit());
  getIt.registerLazySingleton(() => PaymentCubit(orderRepositoryImpl: getIt()));
  getIt.registerLazySingleton(() => PusherChatApp(apiService: getIt()));
  getIt.registerLazySingleton(() => ChatCubit(userRepo: getIt()));
}
