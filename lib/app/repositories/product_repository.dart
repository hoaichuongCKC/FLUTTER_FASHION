import 'package:dartz/dartz.dart';
import 'package:flutter_fashion/app/models/category/category.dart';
import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/network_provider/product_provider.dart';
import 'package:flutter_fashion/core/base/repository/base_repository.dart';

abstract class ProductRepository {
  Future<Either<String, List<CategoryModel>>> fetchCategory();
  Future<Either<String, List<ProductModel>>> fetchListProduct(int page);
  Future<List<ProductModel>> fetchListMoreProduct(int page);
  Future<Either<String, List<ProductModel>>> fetchPopularSearch();
}

class ProductRepositoryImpl extends BaseRepository
    implements ProductRepository {
  final ProductProviderImpl _productProviderImpl;

  ProductRepositoryImpl({
    required super.networkInfoImpl,
    required ProductProviderImpl productProviderImpl,
  }) : _productProviderImpl = productProviderImpl;

  @override
  Future<Either<String, List<CategoryModel>>> fetchCategory() async {
    final result = await baseRepo<List<CategoryModel>>(
      excuteFunction: () async {
        return await _productProviderImpl.fetchCategory();
      },
    );
    return result.fold((error) => Left(error), (data) => Right(data));
  }

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
    return await _productProviderImpl.fetchListProduct(page);
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
}
