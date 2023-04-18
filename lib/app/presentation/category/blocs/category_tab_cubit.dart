import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/app/repositories/product_repository.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';

import '../../../models/product/product.dart';

part 'category_tab_state.dart';

class CategoryTabCubit extends Cubit<CategoryTabState> {
  final ProductRepositoryImpl _productRepositoryImpl;

  late ScrollController _scrollController;

  CategoryTabCubit({required ProductRepositoryImpl product})
      : _productRepositoryImpl = product,
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

      final result = await _productRepositoryImpl.fetchListMoreProduct(1,
          idCagegory: idCategory);

      _productCache[idCategory] = {
        keyPage: 1,
        keyProducts: result,
        keyLoadMore: true,
      };

      emit(state.copyWith(products: result, status: AppStatus.success));
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

      final result = await _productRepositoryImpl.fetchListMoreProduct(page,
          idCagegory: idCategory);

      if (result.isEmpty) {
        _productCache[idCategory]?[keyLoadMore] = false;

        emit(state.copyWith(loading: false));
        return;
      }

      final products = state.products..addAll(result);

      _productCache[idCategory][keyProducts] = products;

      emit(state.copyWith(products: products, loading: false));
    }
  }

  @override
  Future<void> close() {
    _scrollController.removeListener(_loadMore);

    _scrollController.dispose();
    return super.close();
  }
}
