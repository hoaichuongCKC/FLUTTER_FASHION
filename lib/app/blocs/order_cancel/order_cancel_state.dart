part of 'order_cancel_cubit.dart';

@freezed
class OrderCancelState with _$OrderCancelState {
  const factory OrderCancelState.initial() = _Initial;
  const factory OrderCancelState.success({required List<OrderModel> orders}) =
      _Success;
}
