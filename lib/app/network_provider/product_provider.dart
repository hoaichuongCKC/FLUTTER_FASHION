import 'dart:convert';
import 'package:flutter_fashion/app/models/category/category.dart';
import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/core/base/api/api.dart';
import 'package:flutter_fashion/core/base/api/endpoint.dart';
import 'package:flutter_fashion/core/base/exception/exception.dart';

abstract class ProductProvider {
  Future<List<CategoryModel>> fetchCategory();
  Future<List<ProductModel>> fetchListProduct(int page);
}

class ProductProviderImpl extends ProductProvider {
  //
  final ApiService _apiService;

  ProductProviderImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<List<CategoryModel>> fetchCategory() async {
    var response = await _apiService.post(ApiEndpoint.fetchCategory);

    final data = await response.stream.bytesToString();

    if (response.statusCode != 200) {
      throw ServerException();
    }

    return CategoryModel.fromListJson(jsonDecode(data)["data"]);
  }

  @override
  Future<List<ProductModel>> fetchListProduct(int page) async {
    var response =
        await _apiService.post("${ApiEndpoint.fetchProduct}?page=$page");

    final data = await response.stream.bytesToString();

    if (response.statusCode != 200) {
      throw ServerException();
    }

    return ProductModel.productModelFromJson((jsonDecode(data)["data"]));
  }
}
