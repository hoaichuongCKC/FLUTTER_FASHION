part of 'category_cubit.dart';

@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState.initial() = _Initial;
  const factory CategoryState.loading() = _Loading;
  const factory CategoryState.fetchCompleted(List<CategoryModel> list) =
      _FetchCompleted;
  const factory CategoryState.error(String error) = _Error;
}
