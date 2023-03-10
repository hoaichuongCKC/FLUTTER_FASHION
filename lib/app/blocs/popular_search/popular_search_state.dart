part of 'popular_search_cubit.dart';

@freezed
class PopularSearchState with _$PopularSearchState {
  const factory PopularSearchState.initial() = _Initial;
  const factory PopularSearchState.loading() = _Loading;
  const factory PopularSearchState.fetchCompleted(List<ProductModel> list) =
      _FetchCompleted;
  const factory PopularSearchState.error(String error) = _Error;
}
