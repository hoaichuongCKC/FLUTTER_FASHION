import 'package:flutter_fashion/app/blocs/product/product_cubit.dart';
import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:rxdart/rxdart.dart';

class LoadMoreProductBloc {
  //threshold scroll
  final int loadMoreThreshold;

  int _page = 1;

  bool _isLoading = false;

  bool _hasMoreData = true;

  late List<ProductModel> _listProduct;

  //
  late BehaviorSubject<bool> _isLoadingSubject;

  late BehaviorSubject<List<ProductModel>> _productSubject;

  //view UI widget loading
  BehaviorSubject<bool> get isLoading => _isLoadingSubject;

  BehaviorSubject<List<ProductModel>> get getProductStream => _productSubject;

  LoadMoreProductBloc({
    this.loadMoreThreshold = 100,
  }) {
    _isLoadingSubject = BehaviorSubject<bool>.seeded(_isLoading);
    _productSubject = BehaviorSubject<List<ProductModel>>.seeded([]);
    _listProduct = [];
  }

  void dispose() {
    _productSubject.close();
    _isLoadingSubject.close();
  }

  void handleScrollNotification(ScrollController scrollController) async {
    if (_isLoading || !_hasMoreData) return;

    final scrollLimit =
        scrollController.position.maxScrollExtent - loadMoreThreshold;

    if (scrollController.offset >= scrollLimit) {
      _isLoading = true;

      _isLoadingSubject.add(_isLoading);

      _page++;

      final data = await getIt<ProductCubit>().loadMoreProducts(_page);

      if (data.isEmpty) _hasMoreData = false;

      _isLoading = false;

      _isLoadingSubject.add(_isLoading);

      if (data.isEmpty) return;

      _listProduct.addAll(data);

      _productSubject.add(_listProduct);
    }
  }

  onRefresh() {
    _listProduct.clear();
    _page = 1;
    _hasMoreData = true;
    _productSubject.add(_listProduct);
  }
}
