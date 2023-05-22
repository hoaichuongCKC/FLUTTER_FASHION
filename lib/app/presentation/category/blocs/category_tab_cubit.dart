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

  bool get _hasLoadMore => _productCache[state.currentId]?[_keyLoadMore];

  String get _keyProducts => "products";

  String get _keyPage => "page";

  String get _keyLoadMore => "load_more";

  double get _scrollLimit =>
      _scrollController.position.maxScrollExtent - _scrollThresold;

  void changeTab(int idCategory) async {
    emit(state.copyWith(currentId: idCategory));

    if (!_productCache.containsKey(idCategory)) {
      emit(state.copyWith(status: AppStatus.loading));

      if (_checkIdAll(idCategory)) {
        _loadProductAll(idCategory);
        return;
      }

      final result = await _categoryRepo.fetchProductByCate(idCategory, 1);

      result.fold(
        (error) => emit(state.copyWith(status: AppStatus.error)),
        (products) {
          emit(state.copyWith(products: products, status: AppStatus.success));
          _productCache[idCategory] = {
            _keyPage: 1,
            _keyProducts: products,
            _keyLoadMore: true,
          };
        },
      );
    } else {
      emit(state.copyWith(products: _productCache[idCategory][_keyProducts]));
    }
  }

  bool _checkIdAll(int idCategory) {
    return idCategory == -1;
  }

  void _loadProductAll(int idCategory) {
    final products = getIt.get<ProductCubit>().products;

    if (products.isEmpty) {
      return;
    }

    emit(state.copyWith(products: products, status: AppStatus.success));

    _productCache[idCategory] = {
      _keyPage: LoadMoreProductBloc.page,
      _keyProducts: products,
      _keyLoadMore: LoadMoreProductBloc.hasMoreData,
    };
  }

  void initScroll() {
    _scrollController = ScrollController()..addListener(_loadMore);
  }

  void _loadMore() async {
    if (state.loading || !_hasLoadMore) return;

    if (_scrollController.offset >= _scrollLimit) {
      final idCategory = state.currentId;

      emit(state.copyWith(loading: true));

      final page = ++_productCache[idCategory]?[_keyPage];

      _updatePageProductHome(idCategory, page);

      final result = await _categoryRepo.fetchProductByCate(idCategory, page);

      result.fold(
        (error) => emit(state.copyWith(status: AppStatus.error)),
        (products) {
          if (products.isEmpty) {
            _productCache[idCategory]?[_keyLoadMore] = false;
            _updateHasloadmoreProductHome(idCategory);
            emit(state.copyWith(loading: false));
            return;
          }

          final updatedList = [...state.products, ...products];

          emit(state.copyWith(products: updatedList, loading: false));

          _updateProductsHome(products);

          _productCache[idCategory][_keyProducts] = updatedList;
        },
      );
    }
  }

  //update list product home
  _updateProductsHome(List<ProductModel> products) {
    getIt.get<ProductCubit>().addProduct(products);
  }

  _updateHasloadmoreProductHome(idCategory) {
    if (_checkIdAll(idCategory)) {
      LoadMoreProductBloc.hasMoreData = false;
    }
  }

  _updatePageProductHome(idCategory, int page) {
    if (_checkIdAll(idCategory)) {
      LoadMoreProductBloc.page = page;
    }
  }

  @override
  Future<void> close() {
    _scrollController.removeListener(_loadMore);

    _scrollController.dispose();
    return super.close();
  }
}
