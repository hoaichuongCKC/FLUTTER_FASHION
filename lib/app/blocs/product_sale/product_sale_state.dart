part of 'product_sale_cubit.dart';

@freezed
class ProductSaleState with _$ProductSaleState {
  const factory ProductSaleState.initial() = _Initial;
  const factory ProductSaleState.loading() = _Loading;
  const factory ProductSaleState.success(
      {required List<ProductModel> products}) = _Success;
  const factory ProductSaleState.failure(String error) = _Failure;
}
