import 'package:flutter_fashion/app/blocs/category/category_cubit.dart';
import 'package:flutter_fashion/app/models/category/category.dart';
import 'package:flutter_fashion/app/models/range_pice/range_price.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../export.dart';

enum Gender { male, female, none }

class FilterBloc {
  FilterBloc() {
    _genderSubject = BehaviorSubject.seeded(Gender.none);
    _selectPriceSubject = BehaviorSubject.seeded(-1);
    _selectCateSubject = BehaviorSubject.seeded(-1);
    _rangePriceSubject = BehaviorSubject.seeded(RangePriceModel.initList);
    _buildCateSubject = BehaviorSubject.seeded(getIt<CategoryCubit>()
        .state
        .whenOrNull(fetchCompleted: (list) => list)!);
  }

  late BehaviorSubject<Gender> _genderSubject;

  late BehaviorSubject<int> _selectPriceSubject;

  late BehaviorSubject<int> _selectCateSubject;

  late BehaviorSubject<List<RangePriceModel>> _rangePriceSubject;

  late BehaviorSubject<List<CategoryModel>> _buildCateSubject;

  BehaviorSubject<Gender> get genderStream => _genderSubject;

  BehaviorSubject<int> get selectPriceStream => _selectPriceSubject;

  BehaviorSubject<int> get selectCateStream => _selectCateSubject;

  BehaviorSubject<List<CategoryModel>> get buildCateStream => _buildCateSubject;

  BehaviorSubject<List<RangePriceModel>> get rangePirceStream =>
      _rangePriceSubject;

  void selectGender(Gender gender) {
    if (gender == _genderSubject.value) {
      _genderSubject.add(Gender.none);
      return;
    }
    _genderSubject.add(gender);
  }

  void selectPrice(int index) {
    if (index == _selectPriceSubject.value) {
      _selectPriceSubject.add(-1);
      return;
    }
    _selectPriceSubject.add(index);
  }

  void selectCate(int index) {
    if (index == _selectCateSubject.value) {
      _selectCateSubject.add(-1);
      return;
    }
    _selectCateSubject.add(index);
  }

  void reset() {}

  void dispose() {
    _selectPriceSubject.close();
    _genderSubject.close();
    _selectCateSubject.close();
    _rangePriceSubject.close();
    _buildCateSubject.close();
  }
}
