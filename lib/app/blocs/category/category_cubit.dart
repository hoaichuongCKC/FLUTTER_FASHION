import 'package:flutter_fashion/app/models/category/category.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/app/repositories/product_repository.dart';
import 'package:flutter_fashion/core/base/exception/exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_state.dart';
part 'category_cubit.freezed.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final ProductRepositoryImpl _productRepositoryImpl;

  CategoryCubit({required ProductRepositoryImpl productRepositoryImpl})
      : _productRepositoryImpl = productRepositoryImpl,
        super(const CategoryState.initial());

  bool _isLoaded = false;

  void fetchData() async {
    if (!isClosed && !_isLoaded) {
      emit(const CategoryState.loading());
      final result = await _productRepositoryImpl.fetchCategory();
      result.fold(
        (error) {
          if (error != AuthenticatedException.message) {
            emit(CategoryState.error(error));
          }
        },
        (list) {
          _isLoaded = true;
          emit(CategoryState.fetchCompleted(list));
        },
      );
    }
  }

  void onRefresh() async {
    emit(const CategoryState.loading());
    final result = await _productRepositoryImpl.fetchCategory();

    result.fold(
      (error) => emit(CategoryState.error(error)),
      (list) {
        _isLoaded = true;
        emit(CategoryState.fetchCompleted(list));
      },
    );
  }

  int get getLength =>
      state.mapOrNull(fetchCompleted: (value) => value.list.length)!;

  @override
  String toString() {
    super.toString();
    return "state: $state";
  }
}
