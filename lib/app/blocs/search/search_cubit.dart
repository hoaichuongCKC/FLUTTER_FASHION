import 'package:flutter_fashion/app/blocs/user/user_cubit.dart';
import 'package:flutter_fashion/app/models/product/product.dart';
import 'package:flutter_fashion/app/models/range_pice/range_price.dart';
import 'package:flutter_fashion/app/repositories/product_repository.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/storage/key.dart';
import '../../../dependency_injection.dart';
part 'search_state.dart';

class SearchCubit extends HydratedCubit<SearchState> {
  final ProductRepositoryImpl productRepo;

  SearchCubit(this.productRepo) : super(SearchState.init());
  @override
  String get storageToken =>
      KeyStorage.userSearch + getIt.get<UserCubit>().user.id.toString();

  void changedKeyword(String key) => emit(state.copyWith(keyword: key));

  void _addKeyword(String key) {
    final state = this.state;

    final isCheck = state.cacheKeywords.contains(key);

    if (!isCheck) {
      final updatedList = [key, ...state.cacheKeywords];

      emit(state.copyWith(cacheKeywords: updatedList));
    }
  }

  void reset() {
    emit(state.copyWith(products: [], keyword: "", status: AppStatus.init));
  }

  void search(String keyword) async {
    keyword = keyword.trim();
    emit(state.copyWith(status: AppStatus.loading));

    final result = await productRepo.search(page: 1, keyword: keyword);

    result.fold(
      (error) {
        emit(state.copyWith(status: AppStatus.error));
      },
      (products) {
        _addKeyword(keyword);
        emit(state.copyWith(products: products, status: AppStatus.success));
      },
    );
  }

  void filter({String gender = '', int categoryId = -1, int rangePrice = -1}) {
    final state = this.state;

    final products = state.products;

    if (gender.isNotEmpty) {
      if (gender == "Male") {
        gender = "nam";
      } else if (gender == "Female") {
        gender = "nữ";
      }
    }

    final query = List<ProductModel>.from(products)
      ..retainWhere(
        (element) {
          final bool isCheckGender = element.name!.contains(gender);
          final bool isCheckCategory = categoryId > 0
              ? element.category!.id == categoryId
              : element.category!.id > 0;
          final bool isCheckPrice = RangePriceModel.queryPrice(
            rangePrice,
            element.regular_price!,
          );
          return isCheckGender && isCheckCategory && isCheckPrice;
        },
      );

    emit(state.copyWith(products: query));
  }

  void clearHistory() => emit(state.copyWith(cacheKeywords: []));

  @override
  SearchState? fromJson(Map<String, dynamic> json) {
    return SearchState.init(keys: json["keywords"]);
  }

  @override
  Map<String, dynamic>? toJson(SearchState state) {
    return {
      "keywords": state.cacheKeywords,
    };
  }
}
