import 'package:flutter_fashion/app/blocs/product/product_cubit.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:rxdart/rxdart.dart';

class LoadMoreProductBloc {
  //threshold scroll
  final int loadMoreThreshold;

  int _page = 1;

  bool _hasMoreData = true;

  //
  late BehaviorSubject<bool> _isLoadingSubject;

  //view UI widget loading
  BehaviorSubject<bool> get isLoading => _isLoadingSubject;

  LoadMoreProductBloc({
    this.loadMoreThreshold = 100,
  }) {
    _isLoadingSubject = BehaviorSubject<bool>.seeded(false);
  }

  void dispose() {
    _isLoadingSubject.close();
  }

  void handleScrollNotification(
      ScrollController scrollController, BuildContext context) async {
    if (_isLoadingSubject.value || !_hasMoreData) return;

    final scrollLimit =
        scrollController.position.maxScrollExtent - loadMoreThreshold;

    if (scrollController.offset >= scrollLimit) {
      _isLoadingSubject.add(true);

      _page++;

      final data = await getIt<ProductCubit>().loadMoreProducts(_page);

      if (data.isEmpty) _hasMoreData = false;

      _isLoadingSubject.add(false);

      if (data.isEmpty) return;

      // ignore: use_build_context_synchronously
      context.read<ProductCubit>().addProduct(data);
    }
  }

  onRefresh() {
    _page = 1;
    _hasMoreData = true;
  }
}
