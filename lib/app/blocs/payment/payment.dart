import 'package:flutter_fashion/app/blocs/payment/payment_state.dart';
import 'package:flutter_fashion/app/models/promotion/promotion_model.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/app/presentation/payment/components/rules_app_view.dart';
import 'package:flutter_fashion/app/repositories/order_repository.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';
import 'package:flutter_fashion/utils/alert/loading.dart';
import 'package:flutter_fashion/core/base/params/payment.dart';
class PaymentCubit extends Cubit<PaymentState> {
  final OrderRepositoryImpl _orderRepositoryImpl;

  PaymentCubit({required OrderRepositoryImpl orderRepositoryImpl})
      : _orderRepositoryImpl = orderRepositoryImpl,
        super(const PaymentState());

  void changedPhone(String phone) => emit(state.copyWith(phone: phone));

  void changedFullname(String fullname) =>
      emit(state.copyWith(fullname: fullname));

  void changeNote(String note) => emit(state.copyWith(note: note));

  void readRule(bool isCheck) => emit(state.copyWith(isRead: isCheck));

  void removeAll() => emit(const PaymentState());

  void _addPromotion(PromotionModel promotion) {
    emit(state.copyWith(promotion: promotion));
  }

  void cancelPromotion() {
    emit(state.copyWith(
      promotion: const PromotionModel(
          id: 0,
          name:'',
          code: '',
          desc: '',
          order_price_conditions: 0,
          discount_price: 0,
          limit: 0,
          end_date: null,
          created_at: null),
    ));
  }

  void checkPromotion(PromotionModel promotion, context) async {
    loadingAlert(context: context);

    emit(state.copyWith(status: AppStatus.loading));

    final result = await _orderRepositoryImpl.checkPromotion(promotion.id);

    AppRoutes.router.pop();
    result.fold(
      (error) {
        showErrorToast(error);
        emit(state.copyWith(status: AppStatus.error));
      },
      (repsonse) {
        final statusCode = repsonse.data as int;

        if (statusCode != 200) {
          showErrorToast(repsonse.data);
          return;
        }

        _addPromotion(promotion);
      },
    );
  }

  _createOrder(BuildContext context) async {
    emit(state.copyWith(status: AppStatus.loading));
    //get cart
    final cartCubit = getIt.get<CartCubit>().state;

    final cartTotal = cartCubit.totalCart();

    late int total;

    int tempPrice = 0;

    if (state.promotion.id != 0) {
      tempPrice = cartTotal;

      total = (cartTotal - cartTotal * (state.promotion.discount_price / 100))
          .toInt();
    } else {
      total = cartCubit.totalCart();
    }
    //initial param
    final params = OrderParams(
      listCart: cartCubit.items,
      note: state.note,
      shippingAddress: state.address,
      shippingFullname: state.fullname,
      shippingPhone: state.phone,
      total: total,
      tempPrice: tempPrice,
      idPromotion: state.promotion.id != 0 ? state.promotion.id : 0,
    );

    final result = await _orderRepositoryImpl.create(params);

    AppRoutes.router.pop();
    result.fold(
      (error) {
        showErrorToast(error);
        emit(state.copyWith(status: AppStatus.error));
      },
      (order) {
        AppRoutes.router.go("${Routes.PAYMENT}/${Routes.ORDER_SUCCESS}");
        emit(state.copyWith(status: AppStatus.success));
        getIt.get<OrderCubit>().addOrder(order);
      },
    );
  }

  order(context) async {
    if (await _checkInforUser()) {
      if (await _checkRule()) {
        showOrder(context);
        _createOrder(context);
      }
    }
  }

  Future<bool> _checkRule() async {
    if (!state.isRead) {
      showErrorToast(
          "Vui lòng xác nhận đọc điều khoản của bên chúng tôi để tránh mất mác khi nhận hàng");

      return false;
    }
    return true;
  }

  _checkInforUser() async {
    final phone = state.phone;
    final fullname = state.fullname;
    final address = getIt.get<AddressUserCubit>().state.usingAddress;

    if (phone.isEmpty || fullname.isEmpty || address.isEmpty) {
      showErrorToast("Thông tin giao hàng về bạn hiện không đầy đủ");

      return false;
    }
    emit(state.copyWith(address: address[0].name));

    return true;
  }

  @override
  String toString() {
    super.toString();
    return "state: $state";
  }
}
