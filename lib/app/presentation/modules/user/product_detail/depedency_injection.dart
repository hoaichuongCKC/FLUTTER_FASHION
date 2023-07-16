import 'package:flutter_fashion/app/presentation/modules/user/home/export.dart';

Future<void> initProductDetail() async {
  getIt.registerLazySingleton<CartCubit>(() {
    return CartCubit();
  });

  getIt.registerLazySingleton<ProductDetailCubit>(() {
    return ProductDetailCubit(
      productRepo: getIt(),
    );
  });
}
