import 'dart:convert';
import 'dart:developer';
import 'package:flutter_fashion/core/base/api/api.dart';
import 'package:flutter_fashion/core/base/api/endpoint.dart';
import 'package:flutter_fashion/core/base/exception/exception.dart';
import 'package:flutter_fashion/core/models/response_data.dart';

abstract class NotificationProvider {
  Future<Map<String, dynamic>> fetchData(int page, String? type);
  Future<ResponseData> updateReadNoti(int idNoti, String? type);
}

class NotificationProviderImpl extends NotificationProvider {
  final ApiService _apiService;

  NotificationProviderImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Map<String, dynamic>> fetchData(int page, String? type) async {
    late String uri;

    if (type == null) {
      uri = "${ApiEndpoint.fetchNotification}?page=$page";
    } else {
      uri = "${ApiEndpoint.fetchNotification}?page=$page&type=$type";
    }
    var response = await _apiService.post(uri);

    if (response.statusCode != 200) {
      throw ServerException();
    }

    final data = await response.stream.bytesToString();

    final convert = jsonDecode(data)["data"];

    if (convert.isEmpty) {
      return {};
    }

    return convert as Map<String, dynamic>;
  }

  @override
  Future<ResponseData> updateReadNoti(int idNoti, String? type) async {
    var response = await _apiService.post(
      ApiEndpoint.updateRead,
      body: {
        'idNoti': "$idNoti",
        'type': type ??= "",
      },
    );

    if (response.statusCode == 401) {
      throw AuthenticatedException();
    } else if (response.statusCode != 200) {
      throw ServerException();
    }

    final data = await response.stream.bytesToString();
    log("message: $data ");
    return ResponseData.fromJson(jsonDecode(data));
  }
}
