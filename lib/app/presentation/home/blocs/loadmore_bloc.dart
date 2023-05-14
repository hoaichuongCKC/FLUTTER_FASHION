import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:rxdart/rxdart.dart';

class LoadMoreProductBloc {
  //threshold scroll
  final int loadMoreThreshold;

  int _page = 1;

  bool _hasMoreData = true;

  //
  late final BehaviorSubject<bool> _isLoadingSubject =
      BehaviorSubject<bool>.seeded(false);

  //view UI widget loading
  BehaviorSubject<bool> get isLoading => _isLoadingSubject;

  LoadMoreProductBloc({this.loadMoreThreshold = 100});

  void dispose() {
    _isLoadingSubject.close();
  }

  void handleScrollNotification(ScrollController scrollController) async {
    if (_isLoadingSubject.value || !_hasMoreData) return;

    final scrollLimit =
        scrollController.position.maxScrollExtent - loadMoreThreshold;

    if (scrollController.offset >= scrollLimit) {
      _isLoadingSubject.add(true);

      _page++;

      final data = await getIt.get<ProductCubit>().loadMoreProducts(_page);

      _isLoadingSubject.add(false);

      if (data.isEmpty) {
        _hasMoreData = false;
        return;
      }

      getIt.get<ProductCubit>().addProduct(data);
    }
  }
}
