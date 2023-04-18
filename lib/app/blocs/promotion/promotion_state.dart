part of 'promotion_cubit.dart';

@freezed
class PromotionState with _$PromotionState {
  const factory PromotionState.initial() = _Initial;
  const factory PromotionState.loading() = _Loading;
  const factory PromotionState.success(
      {required List<PromotionModel> promotions}) = _Success;
  const factory PromotionState.failure({required String error}) = _Failure;
}
