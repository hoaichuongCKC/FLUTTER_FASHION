import 'dart:developer';

import 'package:flutter_fashion/app/blocs/payment/payment_state.dart';
import 'package:flutter_fashion/core/base/api/api.dart';
import 'package:flutter_fashion/core/base/exception/exception.dart';

import '../../core/base/api/endpoint.dart';

abstract class OrderProvider {
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
}
