import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/app/repositories/category_repository.dart';

import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';

import '../../../models/product/product.dart';

part 'category_tab_state.dart';

class CategoryTabCubit extends Cubit<CategoryTabState> {
  final CategoryRepositoryImpl _categoryRepo;

  late ScrollController _scrollController;

  CategoryTabCubit({required CategoryRepositoryImpl caterepo})
      : _categoryRepo = caterepo,
        super(CategoryTabState.initial());

  double get _scrollThresold => state.scrollThreshold;

  ScrollController get controller => _scrollController;

  final Map<int, dynamic> _productCache = {};

  bool get _hasLoadMore => _productCache[state.currentId]?[keyLoadMore];

  String get keyProducts => "products";

  String get keyPage => "page";

  String get keyLoadMore => "load_more";

  double get _scrollLimit =>
      _scrollController.position.maxScrollExtent - _scrollThresold;

  void changeTab(int idCategory) async {
    emit(state.copyWith(currentId: idCategory));

    if (!_productCache.containsKey(idCategory)) {
      emit(state.copyWith(status: AppStatus.loading));

      final result = await _categoryRepo.fetchProductByCate(idCategory, 1);

      result.fold(
        (error) => emit(state.copyWith(status: AppStatus.error)),
        (products) {
          emit(state.copyWith(products: products, status: AppStatus.success));
          _productCache[idCategory] = {
            keyPage: 1,
            keyProducts: products,
            keyLoadMore: true,
          };
        },
      );
    } else {
      emit(state.copyWith(products: _productCache[idCategory][keyProducts]));
    }
  }

  void initScroll() {
    _scrollController = ScrollController()..addListener(_loadMore);
  }

  void _loadMore() async {
    if (state.loading || !_hasLoadMore) return;

    if (_scrollController.offset >= _scrollLimit) {
      final idCategory = state.currentId;

      emit(state.copyWith(loading: true));

      final page = ++_productCache[idCategory]?[keyPage];

      final result = await _categoryRepo.fetchProductByCate(idCategory, page);

      result.fold(
        (error) => emit(state.copyWith(status: AppStatus.error)),
        (products) {
          if (products.isEmpty) {
            _productCache[idCategory]?[keyLoadMore] = false;

            emit(state.copyWith(loading: false));
            return;
          }

          final updatedList = [...state.products, ...products];

          emit(state.copyWith(products: updatedList, loading: false));

          _productCache[idCategory][keyProducts] = updatedList;
        },
      );
    }
  }

  @override
  Future<void> close() {
    _scrollController.removeListener(_loadMore);

    _scrollController.dispose();
    return super.close();
  }
}
