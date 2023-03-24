import 'dart:convert';
import 'dart:developer';

import 'package:flutter_fashion/app/blocs/payment/payment_state.dart';
import 'package:flutter_fashion/app/models/order/order.dart';
import 'package:flutter_fashion/core/base/api/api.dart';
import 'package:flutter_fashion/core/base/exception/exception.dart';

import '../../core/base/api/endpoint.dart';

abstract class OrderProvider {
  Future<List<OrderModel>> fetchOrder();
  Future<int> create(OrderParams params);
}

class OrderProviderImpl implements OrderProvider {
  final ApiService _apiService;

  OrderProviderImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<int> create(OrderParams params) async {
    var response = await _apiService.post(
      ApiEndpoint.createOrder,
      body: params.toMap(),
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }

    return response.statusCode;
  }

  @override
  Future<List<OrderModel>> fetchOrder() async {
    var response = await _apiService.post(ApiEndpoint.fetchOrder);

    if (response.statusCode != 200) {
      throw ServerException();
    }

    final data = await response.stream.bytesToString();

    final convert = jsonDecode(data)["data"] as List;

    if (convert.isEmpty) {
      return [];
    }
    print(convert);
    return OrderModel.orderModelFromJson(convert);
  }
}
