import 'dart:convert';
import 'package:flutter_fashion/app/models/slider/slider.dart';
import 'package:flutter_fashion/core/base/api/api.dart';
import 'package:flutter_fashion/core/base/api/endpoint.dart';
import 'package:flutter_fashion/core/base/exception/exception.dart';

abstract class BannerProvider {
  Future<List<SliderModel>> fetchBanner();
}

class BannerProviderImpl extends BannerProvider {
  final ApiService _apiService;

  BannerProviderImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<List<SliderModel>> fetchBanner() async {
    var response = await _apiService.post(ApiEndpoint.fetchBanner);

    if (response.statusCode == 401) {
      throw AuthenticatedException();
    } else if (response.statusCode != 200) {
      throw ServerException();
    }

    final data = await response.stream.bytesToString();
    return SliderModel.fromListJson(jsonDecode(data)["data"]);
  }
}
