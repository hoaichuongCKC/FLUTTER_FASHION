import 'package:bloc/bloc.dart';
import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/repositories/product_repository.dart';
import 'package:flutter_fashion/core/base/exception/exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_new_state.dart';
part 'product_new_cubit.freezed.dart';

class ProductNewCubit extends Cubit<ProductNewState> {
  final ProductRepositoryImpl productRepositoryImpl;

  ProductNewCubit(this.productRepositoryImpl)
      : super(const ProductNewState.initial());

  bool _isLoaded = false;

  Future<void> fetchData([int? page]) async {
    if (!_isLoaded) {
      emit(const ProductNewState.loading());

      final result = await productRepositoryImpl.fetchNewProduct(1);

      /// `result.fold()` is a method that takes two functions as arguments, one for handling the
      /// success case and one for handling the error case. In this code, it is used to handle the
      /// result of the `fetchNewProduct()` method call from the `ProductRepositoryImpl` class.
      result.fold(
        (error) {
          if (error != AuthenticatedException.message) {
            emit(ProductNewState.failure(error));
          }
        },
        (products) {
          _isLoaded = true;

          emit(ProductNewState.success(products: products));
        },
      );
    }
  }

  void onRefresh() async {
    fetchData(1);
    _isLoaded = false;
  }
}
