// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_cubit.dart';

class SearchState extends Equatable {
  final String keyword;

  final List<String> cacheKeywords;

  final List<ProductModel> products;

  final AppStatus status;

  const SearchState({
    this.keyword = "",
    this.cacheKeywords = const [],
    this.products = const [],
    this.status = AppStatus.init,
  });

  @override
  List<Object> get props => [cacheKeywords, products, keyword, status];

  factory SearchState.init({List<String>? keys}) {
    if (keys == null || keys.isEmpty) {
      return const SearchState();
    }

    return SearchState(cacheKeywords: keys);
  }

  SearchState copyWith({
    String? keyword,
    List<String>? cacheKeywords,
    List<ProductModel>? products,
    AppStatus? status,
  }) {
    return SearchState(
      keyword: keyword ?? this.keyword,
      cacheKeywords: cacheKeywords ?? this.cacheKeywords,
      products: products ?? this.products,
      status: status ?? this.status,
    );
  }
}
