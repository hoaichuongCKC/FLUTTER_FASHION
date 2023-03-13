import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/repositories/product_repository.dart';
import 'package:rxdart/rxdart.dart';

class CategoryPageBloc {
  final ProductRepositoryImpl productRepository;

  CategoryPageBloc({required this.productRepository}) {
    _categorySelectedSubject = BehaviorSubject<int>.seeded(0);
    _listProductSubject = BehaviorSubject.seeded([]);
    _isLoadingSubject = BehaviorSubject.seeded(false);
    _hashMap = HashMap();
  }

  final int _loadMoreThreshold = 100;

  late Map<int, Map<String, dynamic>> _hashMap;

  late BehaviorSubject<int> _categorySelectedSubject;

  late BehaviorSubject<bool> _isLoadingSubject;

  late BehaviorSubject<List<ProductModel>> _listProductSubject;

  BehaviorSubject<int> get categoryStream => _categorySelectedSubject;

  BehaviorSubject<bool> get isLoading => _isLoadingSubject;

  BehaviorSubject<List<ProductModel>> get listProductStream =>
      _listProductSubject;

  void selectIdCate(int idCategory) {
    if (idCategory == _categorySelectedSubject.value) {
      return;
    }
    _categorySelectedSubject.add(idCategory);

    _fetchData(idCategory);
  }

  void _fetchData(int id) async {
    if (!_hashMap.containsKey(id)) {
      late int page;

      page = _getPage(id);

      final result =
          await productRepository.fetchListMoreProduct(page, idCagegory: id);

      _listProductSubject.add(result);

      _hashMap[id] = {
        "current_page": page,
        "data": _hashMap[id]?["data"] != null
            ? _hashMap[id]!["data"].addAll(result)
            : result,
        "has_load_more": true,
      };
    } else {
      _listProductSubject.add(_hashMap[id]?["data"]);
    }
  }

  loadMore(ScrollController scrollController) async {
    final idCate = _categorySelectedSubject.value;

    final hasLoadMore = _getHasLoadMore(idCate);

    if (_isLoadingSubject.value || !hasLoadMore) return;

    final scrollLimit =
        scrollController.position.maxScrollExtent - _loadMoreThreshold;

    if (scrollController.offset >= scrollLimit) {
      _isLoadingSubject.add(true);

      int page = _getPage(idCate);

      final data = await productRepository.fetchListMoreProduct(++page,
          idCagegory: idCate);

      if (data.isEmpty) _hashMap[idCate]?["has_load_more"] = false;

      _isLoadingSubject.add(false);

      if (data.isEmpty) return;

      _hashMap[idCate]?["current_page"] = page;

      _hashMap[idCate]?["data"].addAll(data);

      _listProductSubject.add(_hashMap[idCate]?["data"]);
    }
  }

  int _getPage(int id) =>
      _hashMap.containsKey(id) ? _hashMap[id]!["current_page"] : 1;

  bool _getHasLoadMore(int id) =>
      _hashMap.containsKey(id) ? _hashMap[id]!["has_load_more"] : false;

  void dispose() {
    _categorySelectedSubject.close();
  }
}
