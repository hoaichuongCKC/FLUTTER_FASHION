import 'dart:developer';
import 'package:flutter_fashion/app/blocs/address_user/address_user_cubit.dart';
import 'package:flutter_fashion/app/blocs/cart/cart_cubit.dart';
import 'package:flutter_fashion/app/blocs/order/order_cubit.dart';
import 'package:flutter_fashion/app/blocs/payment/payment_state.dart';
import 'package:flutter_fashion/app/presentation/home/export.dart';
import 'package:flutter_fashion/app/presentation/payment/components/rules_app_view.dart';
import 'package:flutter_fashion/app/repositories/order_repository.dart';
import 'package:flutter_fashion/core/status_cubit/status_cubit.dart';
import 'package:flutter_fashion/utils/alert/pop_up.dart';

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

  _createOrder(BuildContext context) async {
    final state = this.state;

    emit(state.copyWith(status: AppStatus.loading));
    //get cart
    final cartCubit = getIt.get<CartCubit>().state;
    //initial param
    final params = OrderParams(
      listCart: cartCubit.items,
      note: state.note,
      shippingAddress: state.address,
      shippingFullname: state.fullname,
      shippingPhone: state.phone,
      total: cartCubit.totalCart(),
    );
    final result = await _orderRepositoryImpl.create(params);

    result.fold(
      (error) => emit(state.copyWith(status: AppStatus.error)),
      (order) async {
        context.read<OrderCubit>().addOrder(order);
        emit(state.copyWith(status: AppStatus.success));
        await Future.delayed(const Duration(seconds: 2));
        AppRoutes.router.go(Routes.PROFILE);
        AppRoutes.router.pushNamed(Names.ORDER);
      },
    );
  }

  order(context) async {
    if (await _checkRule(context)) {
      if (await _checkInforUser(context)) {
        showOrder(context);
        _createOrder(context);
      }
    }
  }

  Future<bool> _checkRule(context) async {
    log("Start check rule");
    if (!state.isRead) {
      await popupAlert(
        context: context,
        hasTimer: true,
        counter: 2,
        message:
            "Vui lòng xác nhận đọc điều khoản của bên chúng tôi để tránh mất mác khi nhận hàng",
      );
      return false;
    }
    return true;
  }

  _checkInforUser(context) async {
    log("Start check infor user");
    final phone = state.phone;
    final fullname = state.fullname;
    final address = getIt.get<AddressUserCubit>().state.usingAddress;

    if (phone.isEmpty || fullname.isEmpty || address.isEmpty) {
      await popupAlert(
        context: context,
        hasTimer: true,
        counter: 2,
        message: "Thông tin giao hàng về bạn hiện không đầy đủ",
      );
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
