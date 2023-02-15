import 'dart:convert';

import 'package:flutter_fashion/core/base/api/api.dart';
import 'package:flutter_fashion/core/base/api/endpoint.dart';
import 'package:flutter_fashion/core/base/exception/exception.dart';
import 'package:flutter_fashion/core/base/exception/login_exception.dart';
import 'package:flutter_fashion/core/models/response_data.dart';

abstract class AuthProvider {
  Future<ResponseData> login(String phone, String password);

  Future<ResponseData> loggout();
}

class AuthProviderImpl extends AuthProvider {
  final ApiService _apiService;

  AuthProviderImpl({required ApiService apiService}) : _apiService = apiService;

  @override
  Future<ResponseData> login(String phone, String password) async {
    final body = {
      "phone": phone,
      "password": password,
    };

    var response =
        await _apiService.post(ApiEndpoint.login, body, isRequestHeader: false);

    if (response.statusCode == 201) {
      throw ParamInputException();
    } else {
      if (response.statusCode != 200) {
        throw ServerException();
      }
    }

    return ResponseData.fromJson(jsonDecode(response.body));
  }

  @override
  Future<ResponseData> loggout() async {
    var response = await _apiService.post(ApiEndpoint.loggout, {});

    if (response.statusCode != 200) {
      throw ServerException();
    }

    _apiService.clearHeader();

    return ResponseData.fromJson(jsonDecode(response.body));
  }
}
