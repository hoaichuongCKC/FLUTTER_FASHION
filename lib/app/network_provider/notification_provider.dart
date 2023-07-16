import 'dart:convert';
import 'package:flutter_fashion/app/models/notification/notification_model.dart';
import 'package:flutter_fashion/core/base/api/endpoint.dart';
import 'package:flutter_fashion/core/base/exception/exception.dart';
import 'package:flutter_fashion/core/models/response_data.dart';

import '../../core/parse_json_isolate/notification.dart';
import '../presentation/modules/user/home/export.dart';

abstract class NotificationProvider {
  Future<List<NotificationModel>> fetchData(int page);
  Future<ResponseData> delete(int idNoti);
}

class NotificationProviderImpl extends NotificationProvider {
  final ApiService _apiService;

  NotificationProviderImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<List<NotificationModel>> fetchData(int page) async {
    final String uri = "${ApiEndpoint.fetchNotification}?page=$page";

    var response = await _apiService.post(uri);

    if (response.statusCode != 200) {
      throw ServerException();
    }

    final data = await response.stream.bytesToString();

    final convert = jsonDecode(data);

    final responseApp = ResponseData.fromJson(convert);

    final notifications =
        await compute(parseJson, jsonEncode(responseApp.data));

    return notifications;
  }

  @override
  Future<ResponseData> delete(int idNoti) async {
    final String uri = "${ApiEndpoint.deleteNoti}?id=$idNoti";

    var response = await _apiService.post(uri);

    if (response.statusCode != 200) {
      throw ServerException();
    }
    final data = await response.stream.bytesToString();

    final convert = jsonDecode(data);

    final responseApp = ResponseData.fromJson(convert);

    return responseApp;
  }
}
