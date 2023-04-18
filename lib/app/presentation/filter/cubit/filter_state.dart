// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filter_cubit.dart';

enum Gender { male, female, none }

class FilterState extends Equatable {
  final String gender;

  final int categoryId;

  final int priceIndex;

  final List<RangePriceModel> priceRangies;

  final List<CategoryModel> categories;

  const FilterState({
    this.gender = "",
    this.categoryId = -1,
    this.priceIndex = -1,
    this.priceRangies = const [],
    this.categories = const [],
  });

  factory FilterState.initial() => FilterState(
        priceRangies: RangePriceModel.initList,
        categories: getIt.get<CategoryCubit>().categories,
      );

  @override
  List<Object> get props {
    return [
      gender,
      categoryId,
      priceIndex,
      priceRangies,
      categories,
    ];
  }

  FilterState copyWith({
    String? gender,
    int? categoryId,
    int? priceIndex,
    List<RangePriceModel>? priceRangies,
    List<CategoryModel>? categories,
  }) {
    return FilterState(
      gender: gender ?? this.gender,
      categoryId: categoryId ?? this.categoryId,
      priceIndex: priceIndex ?? this.priceIndex,
      priceRangies: priceRangies ?? this.priceRangies,
      categories: categories ?? this.categories,
    );
  }
}
