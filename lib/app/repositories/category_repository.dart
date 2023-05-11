import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/network_provider/category_provider.dart';
import 'package:flutter_fashion/core/base/repository/base_repository.dart';

import '../models/category/category.dart';

@mustCallSuper
abstract class CategoryRepository {
  Future<Either<String, List<CategoryModel>>> fetchCategory();
  Future<Either<String, List<ProductModel>>> fetchProductByCate(
      int cate, int page);
}

class CategoryRepositoryImpl extends BaseRepository
    implements CategoryRepository {
  final CategoryProviderImpl _categoryProviderImpl;

  CategoryRepositoryImpl({
    required super.networkInfoImpl,
    required CategoryProviderImpl categoryProviderImpl,
  }) : _categoryProviderImpl = categoryProviderImpl;

  @override
  Future<Either<String, List<CategoryModel>>> fetchCategory() async {
    final result = await baseRepo<List<CategoryModel>>(
      excuteFunction: () async {
        return await _categoryProviderImpl.fetchCategory();
      },
    );
    return result.fold((error) => Left(error), (data) => Right(data));
  }

  @override
  Future<Either<String, List<ProductModel>>> fetchProductByCate(
      int cate, int page) async {
    final result = await baseRepo<List<ProductModel>>(
      excuteFunction: () async {
        return await _categoryProviderImpl.fetchProductByCategory(cate, page);
      },
    );
    return result.fold((error) => Left(error), (data) => Right(data));
  }
}
