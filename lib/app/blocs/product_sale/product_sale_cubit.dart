import 'package:bloc/bloc.dart';
import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/repositories/product_repository.dart';
import 'package:flutter_fashion/core/base/exception/exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_sale_state.dart';
part 'product_sale_cubit.freezed.dart';

class ProductSaleCubit extends Cubit<ProductSaleState> {
  final ProductRepositoryImpl productRepositoryImpl;
  ProductSaleCubit(this.productRepositoryImpl)
      : super(const ProductSaleState.initial());

  bool _isLoaded = false;

  Future<void> fetchData([int? page]) async {
    if (!_isLoaded) {
      emit(const ProductSaleState.loading());

      final result = await productRepositoryImpl.fetchSaleProduct(1);

      /// `result.fold()` is a method that takes two functions as arguments, one for handling the
      /// success case and one for handling the error case. In this code, it is used to handle the
      /// result of the `fetchNewProduct()` method call from the `ProductRepositoryImpl` class.
      result.fold(
        (error) {
          if (error != AuthenticatedException.message) {
            emit(ProductSaleState.failure(error));
          }
        },
        (products) {
          _isLoaded = true;
          emit(ProductSaleState.success(products: products));
        },
      );
    }
  }

  void onRefresh() async {
    fetchData(1);
    _isLoaded = false;
  }
}
