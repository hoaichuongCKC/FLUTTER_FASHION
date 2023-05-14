import 'package:bloc/bloc.dart';
import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/repositories/product_repository.dart';
import 'package:flutter_fashion/core/base/exception/exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'popular_search_state.dart';
part 'popular_search_cubit.freezed.dart';

class PopularProductCubit extends Cubit<PopularSearchState> {
  final ProductRepositoryImpl _productRepositoryImpl;
  PopularProductCubit({required ProductRepositoryImpl productRepositoryImpl})
      : _productRepositoryImpl = productRepositoryImpl,
        super(const PopularSearchState.initial());
  bool _isFirstLoaded = false;
  fetchData() async {
    if (!_isFirstLoaded) {
      emit(const PopularSearchState.loading());

      final result = await _productRepositoryImpl.fetchPopularProduct();

      result.fold(
        (error) {
          if (error != AuthenticatedException.message) {
            emit(PopularSearchState.error(error));
          }
        },
        (listPopularSearch) {
          _isFirstLoaded = true;

          emit(PopularSearchState.fetchCompleted(listPopularSearch));
        },
      );
    }
  }

  onRefresh() async {
    emit(const PopularSearchState.loading());
    final result = await _productRepositoryImpl.fetchPopularProduct();

    result.fold((error) => emit(PopularSearchState.error(error)),
        (listPopularSearch) {
      _isFirstLoaded = true;

      emit(PopularSearchState.fetchCompleted(listPopularSearch));
    });
  }

  @override
  String toString() {
    super.toString();
    return "state: $state";
  }
}
