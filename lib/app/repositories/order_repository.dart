import 'package:dartz/dartz.dart';
import 'package:flutter_fashion/app/blocs/payment/payment_state.dart';
import 'package:flutter_fashion/app/network_provider/order_provider.dart';
import 'package:flutter_fashion/core/base/repository/base_repository.dart';

abstract class OrderRepository {
  Future<Either<String, int>> create(OrderParams params);
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
}
