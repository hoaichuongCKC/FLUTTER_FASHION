import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/app/repositories/product_repository.dart';

part 'category_tab_state.dart';

class CategoryTabCubit extends Cubit<CategoryTabState> {
  final ProductRepositoryImpl _productRepositoryImpl;

  late ScrollController _scrollController;

  CategoryTabCubit({required ProductRepositoryImpl product})
      : _productRepositoryImpl = product,
        super(CategoryTabState.initial());

  bool get _isLoading => state.loading;

  double get _scrollThresold => state.scrollThreshold;

  ScrollController get controller => _scrollController;

  Map<int, dynamic> get _map => state.data;

  double get _scrollLimit =>
      _scrollController.position.maxScrollExtent - _scrollThresold;

  void changeTab(int idCategory) async {
    emit(state.copyWith(currentId: idCategory));

    if (!_map.containsKey(idCategory)) {
      final page = _map[idCategory]["page"] ??= 1;

      final result = await _productRepositoryImpl.fetchListMoreProduct(page,
          idCagegory: idCategory);

      _map[idCategory]["products"] = result;

      emit(state.copyWith(data: _map));
    }
  }

  void initScroll() {
    _scrollController = ScrollController()..addListener(_loadMore);
  }

  void _loadMore() {
    if (_isLoading) return;

    if (_scrollController.offset >= _scrollLimit) {
      emit(state.copyWith(loading: !_isLoading));
    }
  }

  void dispose() {
    _scrollController.removeListener(_loadMore);

    _scrollController.dispose();
  }
}
