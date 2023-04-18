import 'package:bloc/bloc.dart';
import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/models/reviews/review.dart';
import 'package:flutter_fashion/app/repositories/product_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_detail_state.dart';
part 'product_detail_cubit.freezed.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final ProductRepositoryImpl productRepo;

  final Map<int, ProductModel> _productCache = {};

  ProductDetailCubit({required this.productRepo})
      : super(const ProductDetailState.initial());

  ProductModel get product => state.whenOrNull(
        success: (product, reviews) => product,
      )!;

  void getProduct(int id) async {
    if (_productCache.containsKey(id)) {
      emit(ProductDetailState.success(product: _productCache[id]!));
    } else {
      emit(const ProductDetailState.loading());

      final result = await productRepo.getDetail(id);

      result.fold(
        (error) => emit(
          ProductDetailState.failure(error: error),
        ),
        (product) {
          _productCache[id] = product;
          emit(ProductDetailState.success(product: product));
        },
      );
    }
  }

  @override
  Future<void> close() {
    _productCache.clear();
    return super.close();
  }
}
