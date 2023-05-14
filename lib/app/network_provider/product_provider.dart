import 'dart:convert';
import 'package:flutter_fashion/app/blocs/create_review/create_review_cubit.dart';
import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/models/promotion/promotion_model.dart';
import 'package:flutter_fashion/app/models/review_chart/review_chart_model.dart';
import 'package:flutter_fashion/core/base/api/api.dart';
import 'package:flutter_fashion/core/base/api/endpoint.dart';
import 'package:flutter_fashion/core/base/exception/exception.dart';
import 'package:flutter_fashion/core/models/response_data.dart';
import 'package:flutter_fashion/core/parse_json_isolate/product.dart';
import 'package:flutter_fashion/export.dart';

@mustCallSuper
abstract class ProductProvider {
  Future<List<ProductModel>> fetchListProduct(int page);

  Future<List<ProductModel>> fetchPopularProduct();

  Future<List<ProductModel>> fetchSaleProduct(int page);

  Future<List<ProductModel>> fetchNewProduct(int page);

  Future<ReviewsModel> fetchReviewProduct(int page, int idProduct);

  Future<ProductModel> getDetail(int idProduct);

  Future<ResponseData> createReview(CreateReviewState params);

  Future<List<PromotionModel>> fetchPromotion(int page);

  Future<List<ProductModel>> search(int page, String keyword);
}

class ProductProviderImpl extends ProductProvider {
  //
  final ApiService _apiService;

  ProductProviderImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<List<ProductModel>> fetchListProduct(
    int page,
  ) async {
    var response =
        await _apiService.post("${ApiEndpoint.fetchProduct}?page=$page");

    if (response.statusCode == 401) {
      throw AuthenticatedException();
    } else if (response.statusCode != 200) {
      throw ServerException();
    }

    final data = await response.stream.bytesToString();

    return await compute(parseProductJson, data);
  }

  @override
  Future<List<ProductModel>> fetchPopularProduct() async {
    var response = await _apiService.post(ApiEndpoint.fetchPopularSearch);

    final data = await response.stream.bytesToString();

    if (response.statusCode == 401) {
      throw AuthenticatedException();
    } else if (response.statusCode != 200) {
      throw ServerException();
    }
    final dataConvert = (jsonDecode(data)["data"]);

    if (dataConvert == null) {
      return [];
    }

    return ProductModel.productModelFromJson(dataConvert);
  }

  @override
  Future<ReviewsModel> fetchReviewProduct(int page, int idProduct) async {
    var response = await _apiService
        .post("${ApiEndpoint.fetchReview}?page=$page&id_product=$idProduct");

    final data = await response.stream.bytesToString();

    if (response.statusCode != 200) {
      throw ServerException();
    }
    final dataConvert = jsonDecode(data)["data"];

    return ReviewsModel.fromJson(dataConvert);
  }

  @override
  Future<ResponseData> createReview(CreateReviewState params) async {
    var response = await _apiService.post(
      ApiEndpoint.create,
      body: params.toJson(),
      images: params.files,
    );

    final data = await response.stream.bytesToString();

    if (response.statusCode != 200) {
      throw ServerException();
    }
    final dataConvert = jsonDecode(data);

    return ResponseData.fromJson(dataConvert);
  }

  @override
  Future<ProductModel> getDetail(int idProduct) async {
    var response = await _apiService
        .post("${ApiEndpoint.getDetail}?id_product=$idProduct");

    final data = await response.stream.bytesToString();

    if (response.statusCode != 200) {
      throw ServerException();
    }
    final dataConvert = jsonDecode(data)["data"];

    return ProductModel.fromJson(dataConvert);
  }

  @override
  Future<List<PromotionModel>> fetchPromotion(int page) async {
    var response =
        await _apiService.post("${ApiEndpoint.fetchPromotion}?page=$page");

    final data = await response.stream.bytesToString();

    if (response.statusCode != 200) {
      throw ServerException();
    }
    final dataConvert = jsonDecode(data)["data"];

    return PromotionModel.promotionModelFromJson(dataConvert);
  }

  @override
  Future<List<ProductModel>> search(int page, String keyword) async {
    var response = await _apiService
        .post("${ApiEndpoint.search}?page=$page&keyword=$keyword");

    if (response.statusCode == 401) {
      throw AuthenticatedException();
    } else if (response.statusCode != 200) {
      throw ServerException();
    }

    final data = await response.stream.bytesToString();

    return await compute(parseProductJson, data);
  }

  @override
  Future<List<ProductModel>> fetchSaleProduct(int page) async {
    var response = await _apiService.post(ApiEndpoint.fetchSaleProduct);

    if (response.statusCode == 401) {
      throw AuthenticatedException();
    } else if (response.statusCode != 200) {
      throw ServerException();
    }

    final data = await response.stream.bytesToString();

    return await compute(parseProductJson, data);
  }

  @override
  Future<List<ProductModel>> fetchNewProduct(int page) async {
    var response = await _apiService.post(ApiEndpoint.fetchNewProducts);

    if (response.statusCode == 401) {
      throw AuthenticatedException();
    } else if (response.statusCode != 200) {
      throw ServerException();
    }

    final data = await response.stream.bytesToString();

    return await compute(parseProductJson, data);
  }
}
