import 'package:bloc/bloc.dart';
import 'package:flutter_fashion/app/models/promotion/promotion_model.dart';
import 'package:flutter_fashion/app/repositories/product_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'promotion_state.dart';
part 'promotion_cubit.freezed.dart';

class PromotionCubit extends Cubit<PromotionState> {
  final ProductRepositoryImpl productRepo;
  PromotionCubit({required this.productRepo})
      : super(const PromotionState.initial());

  int _page = 1;

  void incrementPage() => _page++;

  void fetchPromotion(bool? getAll) async {
    emit(const PromotionState.loading());

    if (getAll != null) incrementPage();

    final result = await productRepo.fetchPromotion(_page);

    result.fold((l) => {emit(PromotionState.failure(error: l))},
        (promotions) => emit(PromotionState.success(promotions: promotions)));
  }
}
