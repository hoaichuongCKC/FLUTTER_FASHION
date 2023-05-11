import 'package:dartz/dartz.dart';
import 'package:flutter_fashion/app/blocs/create_review/create_review_cubit.dart';
import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/models/promotion/promotion_model.dart';
import 'package:flutter_fashion/app/network_provider/product_provider.dart';
import 'package:flutter_fashion/core/base/repository/base_repository.dart';
import 'package:flutter_fashion/core/models/response_data.dart';

import '../models/review_chart/review_chart_model.dart';

abstract class ProductRepository {
  Future<Either<String, List<ProductModel>>> fetchListProduct(int page);

  Future<List<ProductModel>> fetchListMoreProduct(int page);

  Future<Either<String, List<ProductModel>>> fetchPopularSearch();

  Future<Either<String, ReviewsModel>> fetchReviewProduct(
      int page, int idProduct);

  Future<Either<String, ProductModel>> getDetail(int idProduct);

  Future<Either<String, List<PromotionModel>>> fetchPromotion(int page);

  Future<Either<String, ResponseData>> createReview(CreateReviewState params);

  Future<Either<String, List<ProductModel>>> search(
      {required int page, required String keyword});
}

class ProductRepositoryImpl extends BaseRepository
    implements ProductRepository {
  final ProductProviderImpl _productProviderImpl;

  ProductRepositoryImpl({
    required super.networkInfoImpl,
    required ProductProviderImpl productProviderImpl,
  }) : _productProviderImpl = productProviderImpl;

  @override
  Future<Either<String, List<ProductModel>>> fetchListProduct(int page) async {
    final result = await baseRepo<List<ProductModel>>(
      excuteFunction: () async {
        return await _productProviderImpl.fetchListProduct(page);
      },
    );
    return result.fold((error) => Left(error), (data) => Right(data));
  }

  @override
  Future<List<ProductModel>> fetchListMoreProduct(int page) async {
    return await _productProviderImpl.fetchListProduct(
      page,
    );
  }

  @override
  Future<Either<String, List<ProductModel>>> fetchPopularSearch() async {
    final result = await baseRepo<List<ProductModel>>(
      excuteFunction: () async {
        return await _productProviderImpl.fetchPopularSearch();
      },
    );
    return result.fold((error) => Left(error), (data) => Right(data));
  }

  @override
  Future<Either<String, ReviewsModel>> fetchReviewProduct(
      int page, int idProduct) async {
    final result = await baseRepo<ReviewsModel>(
      excuteFunction: () async {
        return await _productProviderImpl.fetchReviewProduct(page, idProduct);
      },
    );
    return result.fold((error) => Left(error), (data) => Right(data));
  }

  @override
  Future<Either<String, ResponseData>> createReview(
      CreateReviewState params) async {
    final result = await baseRepo<ResponseData>(
      excuteFunction: () async {
        return await _productProviderImpl.createReview(params);
      },
    );
    return result.fold((error) => Left(error), (data) => Right(data));
  }

  @override
  Future<Either<String, ProductModel>> getDetail(int idProduct) async {
    final result = await baseRepo<ProductModel>(
      excuteFunction: () async {
        return await _productProviderImpl.getDetail(idProduct);
      },
    );
    return result.fold((error) => Left(error), (data) => Right(data));
  }

  @override
  Future<Either<String, List<PromotionModel>>> fetchPromotion(int page) async {
    final result = await baseRepo<List<PromotionModel>>(
      excuteFunction: () async {
        return await _productProviderImpl.fetchPromotion(page);
      },
    );
    return result.fold((error) => Left(error), (data) => Right(data));
  }

  @override
  Future<Either<String, List<ProductModel>>> search(
      {required int page, required String keyword}) async {
    final result = await baseRepo<List<ProductModel>>(
      excuteFunction: () async {
        return await _productProviderImpl.search(page, keyword);
      },
    );
    return result.fold((error) => Left(error), (data) => Right(data));
  }
}
