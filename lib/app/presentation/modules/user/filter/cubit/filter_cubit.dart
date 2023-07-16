import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/core/models/range_pice/range_price.dart';
import 'package:flutter_fashion/app/presentation/modules/user/home/export.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterState.initial());

  bool get hasValueChange => _checkValue();

  bool _checkValue() {
    if (state.gender.isNotEmpty) {
      return true;
    }

    if (state.isPopular) return state.isPopular;

    if (state.isSale) return state.isSale;

    if (state.priceIndex >= 0) {
      return true;
    }
    return false;
  }

  void changeGender(String gender) => emit(state.copyWith(gender: gender));

  void selectPrice(int index) {
    emit(state.copyWith(priceIndex: index));
  }

  void selectPopular(bool value) {
    emit(state.copyWith(isPopular: value));
  }

  void selectSale(bool value) {
    emit(state.copyWith(isSale: value));
  }

  void filter() {
    final state = this.state;
    if (hasValueChange) {
      final gender = state.gender;
      final isPopular = state.isPopular;
      final isSale = state.isSale;

      final priceIndex = state.priceIndex;
      getIt.get<SearchCubit>().filter(
            gender: gender,
            isPopular: isPopular,
            isSale: isSale,
            rangePrice: priceIndex,
          );
      AppRoutes.router.pop();
    }
  }
}
