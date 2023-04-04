import 'dart:convert';
import 'package:flutter_fashion/app/models/notification/notification_model.dart';
import 'package:flutter_fashion/core/base/api/api.dart';
import 'package:flutter_fashion/core/base/api/endpoint.dart';
import 'package:flutter_fashion/core/base/exception/exception.dart';

abstract class NotificationProvider {
  Future<List<NotificationModel>> fetchData(int page);
}

class NotificationProviderImpl extends NotificationProvider {
  final ApiService _apiService;

  NotificationProviderImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<List<NotificationModel>> fetchData(int page) async {
    var response =
        await _apiService.post("${ApiEndpoint.fetchNotification}?page=$page");

    if (response.statusCode != 200) {
      throw ServerException();
    }

    final data = await response.stream.bytesToString();

    final convert = jsonDecode(data)["data"] as List;

    if (convert.isEmpty) {
      return [];
    }

    return NotificationModel.notiModelFromJson(convert);
  }
}
