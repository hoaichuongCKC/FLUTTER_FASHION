import 'package:dartz/dartz.dart';
import 'package:flutter_fashion/app/blocs/payment/payment_state.dart';
import 'package:flutter_fashion/app/models/order/order.dart';
import 'package:flutter_fashion/app/network_provider/order_provider.dart';
import 'package:flutter_fashion/core/base/repository/base_repository.dart';

abstract class OrderRepository {
  Future<Either<String, int>> create(OrderParams params);
  Future<Either<String, List<OrderModel>>> fetchOrder();
}

class OrderRepositoryImpl extends BaseRepository implements OrderRepository {
  final OrderProviderImpl _orderProviderImpl;

  const OrderRepositoryImpl({
    required OrderProviderImpl orderProviderImpl,
    required super.networkInfoImpl,
  }) : _orderProviderImpl = orderProviderImpl;
  @override
  Future<Either<String, int>> create(OrderParams params) async {
    final result = await baseRepo<int>(
      excuteFunction: () async {
        return await _orderProviderImpl.create(params);
      },
    );
    return result.fold((error) => Left(error), (data) => Right(data));
  }

  @override
  Future<Either<String, List<OrderModel>>> fetchOrder() async {
    final result = await baseRepo<List<OrderModel>>(
      excuteFunction: () async {
        return await _orderProviderImpl.fetchOrder();
      },
    );
    return result.fold((error) => Left(error), (data) => Right(data));
  }
}
