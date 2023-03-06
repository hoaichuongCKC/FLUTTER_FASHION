part of 'product_cubit.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState.initial() = _Initial;
  const factory ProductState.loading() = _Loading;
  const factory ProductState.fetchCompleted(List<ProductModel> list) =
      _FetchCompleted;
  const factory ProductState.error(String error) = _Error;
}
