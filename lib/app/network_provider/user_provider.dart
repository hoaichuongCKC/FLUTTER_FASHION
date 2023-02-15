import 'dart:convert';

import 'package:flutter_fashion/app/models/user/user_model.dart';
import 'package:flutter_fashion/core/base/api/api.dart';
import 'package:flutter_fashion/core/base/api/endpoint.dart';
import 'package:flutter_fashion/core/base/exception/exception.dart';

abstract class UserProvider {
  Future<UserModel> me();
}

class UserProviderImpl extends UserProvider {
  final ApiService _apiService;

  UserProviderImpl({required ApiService apiService}) : _apiService = apiService;

  @override
  Future<UserModel> me() async {
    var response = await _apiService.post(ApiEndpoint.me, {});

    if (response.statusCode == 401) {
      throw AuthenticatedException();
    } else {
      if (response.statusCode != 200) {
        throw ServerException();
      }
    }

    return UserModel.fromJson(jsonDecode(response.body));
  }
}
