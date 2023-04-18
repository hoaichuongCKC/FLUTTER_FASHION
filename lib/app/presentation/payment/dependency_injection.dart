import 'package:flutter_fashion/app/blocs/payment/payment.dart';
import 'package:flutter_fashion/app/network_provider/order_provider.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/app/repositories/order_repository.dart';

Future<void> initDIOrder() async {
  getIt.registerFactory<PaymentCubit>(
      () => PaymentCubit(orderRepositoryImpl: getIt()));

  getIt.registerLazySingleton<OrderRepositoryImpl>(
    () => OrderRepositoryImpl(
      networkInfoImpl: getIt(),
      orderProviderImpl: getIt(),
    ),
  );

  getIt.registerLazySingleton<OrderProviderImpl>(
    () => OrderProviderImpl(
      apiService: getIt(),
    ),
  );
}
