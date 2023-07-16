import 'package:flutter_fashion/app/models/category/category.dart';
import 'package:flutter_fashion/app/presentation/modules/user/home/export.dart';
import 'package:flutter_fashion/app/repositories/category_repository.dart';
import 'package:flutter_fashion/core/base/exception/exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_state.dart';
part 'category_cubit.freezed.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepositoryImpl _categoryRepositoryImpl;

  CategoryCubit({required CategoryRepositoryImpl categoryRepositoryImpl})
      : _categoryRepositoryImpl = categoryRepositoryImpl,
        super(const CategoryState.initial());

  bool _isLoaded = false;

  List<CategoryModel> get categories =>
      state.whenOrNull(fetchCompleted: (list) => list)!;

  void fetchData() async {
    if (!isClosed && !_isLoaded) {
      emit(const CategoryState.loading());
      final result = await _categoryRepositoryImpl.fetchCategory();
      result.fold(
        (error) {
          if (error != AuthenticatedException.message) {
            emit(CategoryState.error(error));
          }
        },
        (categories) {
          _isLoaded = true;
          //create tab all

          emit(CategoryState.fetchCompleted(categories));
        },
      );
    }
  }

  void onRefresh() async {
    emit(const CategoryState.loading());
    final result = await _categoryRepositoryImpl.fetchCategory();

    result.fold(
      (error) => emit(CategoryState.error(error)),
      (list) {
        _isLoaded = true;
        emit(CategoryState.fetchCompleted(list));
      },
    );
  }

  int get length =>
      state.mapOrNull(fetchCompleted: (value) => value.list.length)!;

  @override
  String toString() {
    super.toString();
    return "state: $state";
  }
}
