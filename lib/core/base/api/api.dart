import 'dart:developer';
import 'dart:io';
import 'package:flutter_fashion/core/base/api/endpoint.dart';
import 'package:flutter_fashion/core/storage/key.dart';
import 'package:http/http.dart' as http;
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ApiService {
  ApiService() {
    _initHeader();
  }

  static const String hostDomainLocal = "http://localhost:8000";

  static const String imageUrl = "$hostDomainLocal/storage/";

  static const String baseUrl = "$hostDomainLocal/api/v2.0/";

  Map<String, String> _headers = {};

  Map<String, String> get headers => _headers;

  //call when app started
  void _initHeader() {
    final String? token = HydratedBloc.storage.read(KeyStorage.token);
    //get token

    _headers = {
      'Content-Type': 'application/json',
      "Accept": "application/json",
      "Authorization": token != null ? "Bearer $token" : "",
    };
  }

  void _clearHeader() {
    _headers = {
      'Content-Type': 'application/json',
      "Accept": "application/json",
      "Authorization": "",
    };
  }

  Future<http.StreamedResponse> get(String url) async {
    final uri = Uri.parse("$baseUrl$url");

    http.MultipartRequest request = http.MultipartRequest('GET', uri);

    http.StreamedResponse response = await request.send();

    if (ApiEndpoint.loggout == url || response.statusCode == 401) {
      _clearHeader();
    }

    return response;
  }

  Future<http.StreamedResponse> post(
    String url, {
    Map<String, String>? body,
    bool isRequestHeader = true,
    List<File>? images,
  }) async {
    if (isRequestHeader) {
      if (_headers["Authorization"] == null ||
          _headers["Authorization"]!.isEmpty) {
        log("authortization null");
        _initHeader();
      }
    }

    final uri = Uri.parse("$baseUrl$url");

    http.MultipartRequest request = http.MultipartRequest('POST', uri)
      ..fields.addAll(body ?? {})
      ..headers.addAll(isRequestHeader ? _headers : {});

    if (images != null) {
      for (File file in images) {
        http.MultipartFile multipartFile =
            await http.MultipartFile.fromPath('image[]', file.path);
        //add filed file
        request.files.add(multipartFile);
      }
    }

    //send request up to server
    http.StreamedResponse response = await request.send();
    if (ApiEndpoint.loggout == url || response.statusCode == 401) {
      _clearHeader();
    }

    return response;
  }
}
