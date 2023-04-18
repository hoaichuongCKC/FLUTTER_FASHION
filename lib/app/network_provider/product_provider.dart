import 'dart:convert';
import 'package:flutter_fashion/app/blocs/create_review/create_review_cubit.dart';
import 'package:flutter_fashion/app/models/category/category.dart';
import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/models/promotion/promotion_model.dart';
import 'package:flutter_fashion/app/models/reviews/review.dart';
import 'package:flutter_fashion/core/base/api/api.dart';
import 'package:flutter_fashion/core/base/api/endpoint.dart';
import 'package:flutter_fashion/core/base/exception/exception.dart';
import 'package:flutter_fashion/core/models/response_data.dart';

abstract class ProductProvider {
  Future<List<CategoryModel>> fetchCategory();

  Future<List<ProductModel>> fetchListProduct(int page, {int idCagegory = 1});

  Future<List<ProductModel>> fetchPopularSearch();

  Future<List<ReviewModel>> fetchReviewProduct(int page, int idProduct);

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
  Future<List<ProductModel>> fetchListProduct(int page,
      {int idCagegory = 1}) async {
    var response = await _apiService
        .post("${ApiEndpoint.fetchProduct}?page=$page&type=$idCagegory");

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
  Future<List<ProductModel>> fetchPopularSearch() async {
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
  Future<List<ReviewModel>> fetchReviewProduct(int page, int idProduct) async {
    var response = await _apiService
        .post("${ApiEndpoint.fetchReview}?page=$page&id_product=$idProduct");

    final data = await response.stream.bytesToString();

    if (response.statusCode != 200) {
      throw ServerException();
    }
    final dataConvert = jsonDecode(data)["data"];

    if (dataConvert == null) {
      return [];
    }

    return ReviewModel.fromListJson(dataConvert);
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

    final data = await response.stream.bytesToString();

    if (response.statusCode == 401) {
      throw AuthenticatedException();
    } else if (response.statusCode != 200) {
      throw ServerException();
    }

    final dataConvert = (jsonDecode(data)["data"]) as List;

    if (dataConvert.isEmpty) {
      return [];
    }

    return ProductModel.productModelFromJson(dataConvert);
  }
}
