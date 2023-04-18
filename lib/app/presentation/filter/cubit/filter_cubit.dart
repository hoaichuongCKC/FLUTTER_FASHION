import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/app/blocs/category/category_cubit.dart';
import 'package:flutter_fashion/app/blocs/search/search_cubit.dart';
import 'package:flutter_fashion/app/models/category/category.dart';
import 'package:flutter_fashion/app/models/range_pice/range_price.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterState.initial());

  bool get hasValueChange => _checkValue();

  bool _checkValue() {
    if (state.gender.isNotEmpty) {
      return true;
    }
    if (state.categoryId > 0) {
      return true;
    }
    if (state.priceIndex > 0) {
      return true;
    }
    return false;
  }

  void changeGender(String gender) => emit(state.copyWith(gender: gender));

  void changeCategory(int id) {
    emit(state.copyWith(categoryId: id));
  }

  void selectPrice(int index) {
    emit(state.copyWith(priceIndex: index));
  }

  void filter() {
    final state = this.state;
    if (hasValueChange) {
      final gender = state.gender;
      final categoryId = state.categoryId;
      final priceIndex = state.priceIndex;
      getIt.get<SearchCubit>().filter(
            gender: gender,
            categoryId: categoryId,
            rangePrice: priceIndex,
          );
    }
  }
}
