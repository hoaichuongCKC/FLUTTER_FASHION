import 'package:bloc/bloc.dart';
import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/repositories/product_repository.dart';
import 'package:flutter_fashion/core/base/exception/exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_state.dart';
part 'product_cubit.freezed.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepositoryImpl _productRepositoryImpl;
  ProductCubit({required ProductRepositoryImpl productRepositoryImpl})
      : _productRepositoryImpl = productRepositoryImpl,
        super(const ProductState.initial());
  bool _isLoaded = false;

  List<ProductModel> get products => state.whenOrNull(
        fetchCompleted: (products) => products,
      )!;

  Future<void> fetchData([int? page]) async {
    if (!_isLoaded) {
      emit(const ProductState.loading());

      final result = await _productRepositoryImpl.fetchListProduct(1);

      result.fold(
        (error) {
          if (error != AuthenticatedException.message) {
            emit(ProductState.error(error));
          }
        },
        (data) {
          _isLoaded = true;
          emit(ProductState.fetchCompleted(data));
        },
      );
    }
  }

  void addProduct(List<ProductModel> data) {
    final state = this.state;
    final listState = state.whenOrNull(fetchCompleted: (list) => list)!;
    emit(ProductState.fetchCompleted([...listState, ...data]));
  }

  void onRefresh() async {
    fetchData(1);
    _isLoaded = false;
  }

  Future<List<ProductModel>> loadMoreProducts(int page) async {
    final result = await _productRepositoryImpl.fetchListMoreProduct(page);
    return result;
  }
}
