import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/repositories/product_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_state.dart';
part 'product_cubit.freezed.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepositoryImpl _productRepositoryImpl;
  ProductCubit({required ProductRepositoryImpl productRepositoryImpl})
      : _productRepositoryImpl = productRepositoryImpl,
        super(const ProductState.initial());
  bool _isLoaded = false;

  late bool isLoadingMore;

  late List<ProductModel> _productList;

  final double _threshold = 150.0;

  int _page = 1;

  Future<void> fetchData([int? page]) async {
    if (!_isLoaded) {
      emit(const ProductState.loading());

      final result =
          await _productRepositoryImpl.fetchListProduct(page ?? _page);

      result.fold(
        (error) => emit(ProductState.error(error)),
        (data) {
          _isLoaded = true;
          emit(ProductState.fetchCompleted(data));
        },
      );
    }
  }

  void onRefresh() async {
    fetchData(1);
  }

  void loadMoreProducts(ScrollController controller) async {
    final offset = controller.offset;
    final maxScroll = controller.position.maxScrollExtent;
    final outOfRange = controller.position.outOfRange;
    if (_isLoaded) {
      if (offset >= maxScroll - _threshold && !outOfRange && !isLoadingMore) {
        isLoadingMore = true;
        _page++;
      }
    }
  }

  @override
  String toString() {
    super.toString();
    return "state: $state";
  }
}
