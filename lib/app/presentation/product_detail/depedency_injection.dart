import 'package:flutter_fashion/app/blocs/cart/cart_cubit.dart';
import 'package:flutter_fashion/app/blocs/product_detail/product_detail_cubit.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';

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
