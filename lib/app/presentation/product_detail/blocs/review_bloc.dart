import 'dart:collection';
import 'dart:developer';
import 'package:flutter_fashion/app/models/reviews/review.dart';
import 'package:flutter_fashion/app/repositories/product_repository.dart';
import 'package:rxdart/rxdart.dart';

class ReviewBLoc {
  final ProductRepositoryImpl _productRepositoryImpl;
  ReviewBLoc({required ProductRepositoryImpl productRepositoryImpl})
      : _productRepositoryImpl = productRepositoryImpl {
    _hashMap = HashMap();
    _isLoadMore = BehaviorSubject.seeded(true);
    _listReviewSubject = BehaviorSubject.seeded([]);
  }
  //view button load more bool
  late BehaviorSubject<bool> _isLoadMore;

  late BehaviorSubject<List<ReviewModel>> _listReviewSubject;

  late Map<int, dynamic> _hashMap;

  BehaviorSubject<bool> get loadMoreStream => _isLoadMore;

  BehaviorSubject<List<ReviewModel>> get listReviewStream => _listReviewSubject;

  int _idProduct = 0;

  void fetchData(int idProduct) async {
    _idProduct = idProduct;
    if (!_hashMap.containsKey(idProduct)) {
      //get page
      final page = _getPage(idProduct);

      final result =
          await _productRepositoryImpl.fetchReviewProduct(page, idProduct);

      result.fold(
        (error) => log(error, name: "ReviewBloc-Error"),
        (data) {
          if (data.isNotEmpty) {
            _listReviewSubject.add(data);
            //save data in hashMap
            _addMap(idProduct, {"data": data, "current_page": page});
          }
        },
      );
    } else {
      _fetchDataFromHashMap(idProduct);
    }
  }

  void fetchLoadMore() async {
    int page = _getPage(_idProduct);

    final result =
        await _productRepositoryImpl.fetchReviewProduct(++page, _idProduct);
    result.fold(
      (error) => log(error, name: "ReviewBloc-Error-(loadMore)"),
      (data) {
        _isLoadMore.add(false);
        if (data.isNotEmpty) {
          final getList = _hashMap[_idProduct]["data"];

          getList.addAll(data);

          _listReviewSubject.add(getList);
        }
      },
    );
  }

  _fetchDataFromHashMap(int idProduct) =>
      _listReviewSubject.add(_hashMap[idProduct]["data"]);

  void _addMap(int key, dynamic value) =>
      _hashMap.putIfAbsent(key, () => value);

  int _getPage(int idProduct) =>
      _hashMap.containsKey(idProduct) ? _hashMap[idProduct]["current_page"] : 1;
}
