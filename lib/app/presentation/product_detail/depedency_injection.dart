import 'package:flutter_fashion/app/blocs/cart/cart_cubit.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/app/presentation/product_detail/blocs/review_bloc.dart';

Future<void> initProductDetail() async {
  getIt.registerLazySingleton(
    () => ReviewBLoc(productRepositoryImpl: getIt()),
  );

  getIt.registerLazySingleton<CartCubit>(() {
    return CartCubit();
  });
}
