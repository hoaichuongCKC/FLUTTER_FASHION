// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'category_tab_cubit.dart';

class CategoryTabState extends Equatable {
  final List<ProductModel> products;

  final double scrollThreshold;

  final bool loading;

  final int currentId;

  final AppStatus status;

  const CategoryTabState({
    this.products = const [],
    this.scrollThreshold = 150.0,
    this.loading = false,
    this.currentId = 0,
    this.status = AppStatus.init,
  });

  factory CategoryTabState.initial() => const CategoryTabState();

  @override
  List<Object?> get props =>
      [status, products, loading, scrollThreshold, currentId];

  CategoryTabState copyWith({
    List<ProductModel>? products,
    double? scrollThreshold,
    bool? loading,
    int? currentId,
    AppStatus? status,
  }) {
    return CategoryTabState(
      products: products ?? this.products,
      scrollThreshold: scrollThreshold ?? this.scrollThreshold,
      loading: loading ?? this.loading,
      currentId: currentId ?? this.currentId,
      status: status ?? this.status,
    );
  }
}
