import 'dart:convert';
import 'package:flutter_fashion/app/models/category/category.dart';
import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/core/base/api/endpoint.dart';
import 'package:flutter_fashion/core/base/exception/exception.dart';
import 'package:flutter_fashion/core/parse_json_isolate/product.dart';

import '../../export.dart';

@mustCallSuper
abstract class CategoryProvider {
  Future<List<CategoryModel>> fetchCategory();
  Future<List<ProductModel>> fetchProductByCategory(int cate, int page);
}

class CategoryProviderImpl extends CategoryProvider {
  final ApiService _apiService;

  CategoryProviderImpl({required ApiService apiService})
      : _apiService = apiService;
  @override
  Future<List<CategoryModel>> fetchCategory() async {
    var response = await _apiService.post(ApiEndpoint.fetchCategory);

    final data = await response.stream.bytesToString();

    if (response.statusCode == 401) {
      throw AuthenticatedException();
    } else if (response.statusCode != 200) {
      throw ServerException();
    }

    return CategoryModel.fromListJson(jsonDecode(data)["data"]);
  }

  @override
  Future<List<ProductModel>> fetchProductByCategory(int cate, int page) async {
    var response = await _apiService
        .post("${ApiEndpoint.fetchProductByCate}?cate=$cate&page=$page");

    if (response.statusCode == 401) {
      throw AuthenticatedException();
    } else if (response.statusCode != 200) {
      throw ServerException();
    }

    final data = await response.stream.bytesToString();

    return await compute(parseProductJson, data);
  }
}
