part of 'product_new_cubit.dart';

@freezed
class ProductNewState with _$ProductNewState {
  const factory ProductNewState.initial() = _Initial;
  const factory ProductNewState.loading() = _Loading;
  const factory ProductNewState.success(
      {required List<ProductModel> products}) = _Success;
  const factory ProductNewState.failure(String error) = _Failure;
}
