// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'category_tab_cubit.dart';

class CategoryTabState extends Equatable {
  final Map<int, dynamic> data;

  final double scrollThreshold;

  final bool loading;

  final int currentId;

  const CategoryTabState({
    this.data = const {},
    this.scrollThreshold = 150.0,
    this.loading = false,
    this.currentId = 1,
  });

  factory CategoryTabState.initial() => const CategoryTabState();

  @override
  List<Object?> get props => [currentId, data, loading, scrollThreshold];

  CategoryTabState copyWith({
    Map<int, dynamic>? data,
    double? scrollThreshold,
    bool? loading,
    int? currentId,
  }) {
    return CategoryTabState(
      data: data ?? this.data,
      scrollThreshold: scrollThreshold ?? this.scrollThreshold,
      loading: loading ?? this.loading,
      currentId: currentId ?? this.currentId,
    );
  }
}
