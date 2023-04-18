part of 'product_detail_cubit.dart';

@freezed
class ProductDetailState with _$ProductDetailState {
  const factory ProductDetailState.initial() = _Initial;
  const factory ProductDetailState.loading() = _Loading;
  const factory ProductDetailState.failure({required String error}) = _Error;
  const factory ProductDetailState.success(
      {required ProductModel product, List<ReviewModel>? reviews}) = _Success;
}
