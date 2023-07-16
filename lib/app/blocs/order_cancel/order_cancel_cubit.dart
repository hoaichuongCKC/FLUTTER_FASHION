import 'package:equatable/equatable.dart';
import 'package:flutter_fashion/app/models/order/order.dart';
import 'package:flutter_fashion/app/presentation/modules/user/home/export.dart';
import 'package:flutter_fashion/utils/alert/loading.dart';
import '../../../core/storage/key.dart';
import '../../repositories/order_repository.dart';

part 'order_cancel_state.dart';

class OrderCancelCubit extends HydratedCubit<OrderCancelState> {
  final OrderRepositoryImpl orderRepo;
  OrderCancelCubit(this.orderRepo) : super(const OrderCancelState());

  @override
  String get storageToken =>
      KeyStorage.userCancelOrder + getIt.get<UserCubit>().user.id.toString();

  void addOrder(OrderModel order) {
    emit(state.copyWith(orders: [order, ...state.orders]));
  }

  void remove(int id) {
    final updatedList = List<OrderModel>.from(state.orders)
      ..removeWhere((element) => element.id == id);

    emit(state.copyWith(orders: updatedList));
  }

  void checkBuyAgain(BuildContext context, int orderID) async {
    loadingAlert(context: context);
    final order = List<OrderModel>.from(state.orders)
        .firstWhere((element) => element.id == orderID);
    final reuslt = await orderRepo.checkOrderBuyAgain(order.order_detail!);
    AppRoutes.router.pop();
    reuslt.fold(
      (error) {
        showErrorToast("Something wrong!");
      },
      (data) {
        if (data.message == 'Price changed') {
          showDialog<String>(
            context: context,
            builder: (context) {
              return AlertDialog(
                surfaceTintColor: lightColor,
                backgroundColor: lightColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(radiusBtn * 2),
                  ),
                ),
                titleTextStyle: const TextStyle(
                  fontSize: 16.0,
                  color: darkColor,
                  fontWeight: FontWeight.w500,
                ),
                contentTextStyle: TextStyle(
                  fontSize: 12.0,
                  color: textDisable,
                  fontWeight: FontWeight.w400,
                ),
                title: Text(AppLocalizations.of(context)!.pr_price_has_changed),
                content: Text(AppLocalizations.of(context)!.pls_add_new_pr),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  ButtonWidget(
                    onPressed: () {
                      AppRoutes.router.go(Routes.HOME);
                      AppRoutes.router.pushNamed(
                        Names.CATEGORY,
                        queryParams: {
                          "index": "0",
                        },
                      );
                      remove(order.id!);
                    },
                    height: 35,
                    width: 120,
                    child: Text(
                      AppLocalizations.of(context)!.buy,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: lightColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
          return;
        }
        getIt.get<CartCubit>().addToListCart(order.order_detail!);
        remove(order.id!);
        AppRoutes.router.go(Routes.HOME);
        AppRoutes.router.push(Routes.CART);
      },
    );
  }

  @override
  OrderCancelState? fromJson(Map<String, dynamic> json) {
    final convert = (json["state"]);

    if (convert == null) return const OrderCancelState();

    final list = OrderModel.orderListFromJson(convert);

    return OrderCancelState(orders: list);
  }

  @override
  Map<String, dynamic>? toJson(OrderCancelState state) {
    return {
      "state": state.toJson(),
    };
  }
}
