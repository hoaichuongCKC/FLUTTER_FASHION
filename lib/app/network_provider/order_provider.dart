import 'dart:convert';
import 'package:flutter_fashion/app/models/order/order.dart';
import 'package:flutter_fashion/core/base/api/api.dart';
import 'package:flutter_fashion/core/base/exception/exception.dart';
import 'package:flutter_fashion/core/models/response_data.dart';
import 'package:flutter_fashion/core/base/params/payment.dart';
import '../../core/base/api/endpoint.dart';
import '../models/cart/cart.dart';

abstract class OrderProvider {
  Future<Map<String, dynamic>> fetchOrder();

  Future<OrderModel> create(OrderParams params);

  Future<int> delete(int orderId);

  Future<ResponseData> checkPromotion(int idPromotion);

  Future<ResponseData> checkOrderBuyAgain(List<CartModel> carts);
}

class OrderProviderImpl implements OrderProvider {
  final ApiService _apiService;

  OrderProviderImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<OrderModel> create(OrderParams params) async {
    var response = await _apiService.post(
      ApiEndpoint.createOrder,
      body: params.toMap(),
    );

    if (response.statusCode != 200) {
      print('order: ${await response.stream.bytesToString()}');
      throw ServerException();
    }
    final data = await response.stream.bytesToString();

    final convert = jsonDecode(data);

    final order = ResponseData.fromJson(convert);

    return OrderModel.fromJson(order.data);
  }

  @override
  Future<Map<String, dynamic>> fetchOrder() async {
    var response = await _apiService.post(ApiEndpoint.fetchOrder);

    if (response.statusCode != 200) {
      throw ServerException();
    }

    final data = await response.stream.bytesToString();

    final convert = jsonDecode(data)["data"] as Map<String, dynamic>;

    if (convert.isEmpty) {
      return {};
    }

    return convert;
  }

  @override
  Future<int> delete(int orderId) async {
    var response =
        await _apiService.post("${ApiEndpoint.deleteOrder}?order_id=$orderId");

    if (response.statusCode != 200) {
      throw ServerException();
    }

    return response.statusCode;
  }

  @override
  Future<ResponseData> checkPromotion(int idPromotion) async {
    var response = await _apiService.post(
      ApiEndpoint.checkPromotion,
      body: {
        "idPromotion": "$idPromotion",
      },
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }
    final data = await response.stream.bytesToString();

    return ResponseData.fromJson(jsonDecode(data));
  }

  @override
  Future<ResponseData> checkOrderBuyAgain(List<CartModel> carts) async {
    var response = await _apiService.post(
      ApiEndpoint.checkOrderBuyAgain,
      body: {
        "products": jsonEncode(carts),
      },
    );

    if (response.statusCode != 200) {
      print('order: ${await response.stream.bytesToString()}');
      throw ServerException();
    }
    final data = await response.stream.bytesToString();

    return ResponseData.fromJson(jsonDecode(data));
  }
}
