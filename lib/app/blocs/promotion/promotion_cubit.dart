import 'package:bloc/bloc.dart';
import 'package:flutter_fashion/app/models/promotion/promotion_model.dart';
import 'package:flutter_fashion/app/repositories/product_repository.dart';
import 'package:flutter_fashion/core/base/exception/exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'promotion_state.dart';
part 'promotion_cubit.freezed.dart';

class PromotionCubit extends Cubit<PromotionState> {
  final ProductRepositoryImpl productRepo;
  PromotionCubit({required this.productRepo})
      : super(const PromotionState.initial());

  int _page = 1;

  bool _isFirstLoad = false;

  List<PromotionModel> get promotions => state.whenOrNull(
        success: (promotions) => promotions,
      )!;

  void incrementPage() => _page++;

  void fetchPromotion([bool? getAll]) async {
    if (!_isFirstLoad) {
      emit(const PromotionState.loading());

      if (getAll != null) incrementPage();

      final result = await productRepo.fetchPromotion(_page);

      result.fold((error) {
        if (error != AuthenticatedException.message) {
          emit(PromotionState.failure(error: error));
        }
      }, (promotions) {
        _isFirstLoad = !_isFirstLoad;
        emit(PromotionState.success(promotions: promotions));
      });
    }
  }

  void onRefresh() {
    _isFirstLoad = !_isFirstLoad;
    fetchPromotion(null);
  }
}
