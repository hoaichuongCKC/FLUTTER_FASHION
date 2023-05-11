// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filter_cubit.dart';

enum Gender { male, female, none }

class FilterState extends Equatable {
  final String gender;

  final int priceIndex;

  final bool isPopular;

  final bool isSale;

  final List<RangePriceModel> priceRangies;

  const FilterState({
    this.gender = "",
    this.isPopular = false,
    this.isSale = false,
    this.priceIndex = -1,
    this.priceRangies = const [],
  });

  factory FilterState.initial() => FilterState(
        priceRangies: RangePriceModel.initList,
      );

  @override
  List<Object> get props {
    return [
      gender,
      priceIndex,
      isPopular,
      isSale,
      priceRangies,
    ];
  }

  FilterState copyWith({
    String? gender,
    int? priceIndex,
    bool? isPopular,
    bool? isSale,
    List<RangePriceModel>? priceRangies,
  }) {
    return FilterState(
      gender: gender ?? this.gender,
      priceIndex: priceIndex ?? this.priceIndex,
      isPopular: isPopular ?? this.isPopular,
      isSale: isSale ?? this.isSale,
      priceRangies: priceRangies ?? this.priceRangies,
    );
  }
}
