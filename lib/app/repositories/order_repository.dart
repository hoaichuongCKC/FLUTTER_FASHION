import 'package:dartz/dartz.dart';
import 'package:flutter_fashion/app/blocs/payment/payment_state.dart';
import 'package:flutter_fashion/app/models/order/order.dart';
import 'package:flutter_fashion/app/network_provider/order_provider.dart';
import 'package:flutter_fashion/core/base/repository/base_repository.dart';
import 'package:flutter_fashion/core/models/response_data.dart';

abstract class OrderRepository {
  Future<Either<String, OrderModel>> create(OrderParams params);
  Future<Either<String, Map<String, dynamic>>> fetchOrder();
  Future<Either<String, ResponseData>> updatedLimitPromotion(int idPromo);
  Future<Either<String, int>> delete(int orderId);
}

class OrderRepositoryImpl extends BaseRepository implements OrderRepository {
  final OrderProviderImpl _orderProviderImpl;

  const OrderRepositoryImpl({
    required OrderProviderImpl orderProviderImpl,
    required super.networkInfoImpl,
  }) : _orderProviderImpl = orderProviderImpl;
  @override
  Future<Either<String, OrderModel>> create(OrderParams params) async {
    final result = await baseRepo<OrderModel>(
      excuteFunction: () async {
        return await _orderProviderImpl.create(params);
      },
    );
    return result.fold((error) => Left(error), (data) => Right(data));
  }

  @override
  Future<Either<String, Map<String, dynamic>>> fetchOrder() async {
    final result = await baseRepo<Map<String, dynamic>>(
      excuteFunction: () async {
        return await _orderProviderImpl.fetchOrder();
      },
    );
    return result.fold((error) => Left(error), (data) => Right(data));
  }

  @override
  Future<Either<String, int>> delete(int orderId) async {
    final result = await baseRepo<int>(
      excuteFunction: () async {
        return await _orderProviderImpl.delete(orderId);
      },
    );
    return result.fold((error) => Left(error), (data) => Right(data));
  }

  @override
  Future<Either<String, ResponseData>> updatedLimitPromotion(
      int idPromo) async {
    final result = await baseRepo<ResponseData>(
      excuteFunction: () async {
        return await _orderProviderImpl.updatedLimitPromotion(idPromo);
      },
    );
    return result.fold((error) => Left(error), (data) => Right(data));
  }
}
